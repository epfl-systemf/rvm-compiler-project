import tvm
from tvm import meta_schedule as ms
from tvm.tir import schedule as sch
from tvm import relay
from tvm.relay.backend import Executor
from tvm.relax.transform import LegalizeOps
from tvm.script import ir as I, relax as R, tir as T
from tvm.tir import TensorIntrin
from tvm import tir
from tvm.ir.module import IRModule
from types import MappingProxyType
import tempfile

from tvm.contrib import graph_executor, utils
from tvm.contrib.micro.meta_schedule.local_builder_micro import get_local_builder_micro
from tvm.contrib.micro.meta_schedule.rpc_runner_micro import get_rpc_runner_micro

from tvm.tir.tensor_intrin.x86 import AVX512_DOT_16x4_INTRIN as AVX512_INTRIN

import os
import numpy as np

SKYLAKE_AVX512_TARGET = "llvm -mtriple=x86_64-unknown-linux-gnu -mcpu=skylake-avx512 -num-cores 4"

def _get_schedule_rules_for_x86(intrin):
    return [
        ms.schedule_rule.ApplyCustomRule(),
        ms.schedule_rule.AutoInline(
            into_producer=False,
            into_consumer=True,
            inline_const_tensor=True,
            disallow_if_then_else=True,
            require_injective=True,
            require_ordered=True,
            disallow_op=["tir.exp"],
        ),
        ms.schedule_rule.AddRFactor(max_jobs_per_core=16, max_innermost_factor=64),
        ms.schedule_rule.MultiLevelTilingWithIntrin(
            intrin,
            structure="SSRSRS",
            tile_binds=None,
            max_innermost_factor=64,
            vector_load_lens=None,
            reuse_read=None,
            reuse_write=ms.schedule_rule.ReuseType(
                req="may",
                levels=[1, 2],
                scope="global",
            ),
        ),
        ms.schedule_rule.MultiLevelTiling(
            structure="SSRSRS",
            tile_binds=None,
            max_innermost_factor=64,
            vector_load_lens=None,
            reuse_read=None,
            reuse_write=ms.schedule_rule.ReuseType(
                req="may",
                levels=[1, 2],
                scope="global",
            ),
        ),
        ms.schedule_rule.ParallelizeVectorizeUnroll(
            max_jobs_per_core=16,
            max_vectorize_extent=64,
            unroll_max_steps=[0, 16, 64, 512],
            unroll_explicit=True,
        ),
        ms.schedule_rule.RandomComputeLocation(),
    ]

SCH_RULES_FOR_AVX512 = _get_schedule_rules_for_x86(AVX512_INTRIN)

POSTPROCS_FOR_VNNI = [
    ms.postproc.DisallowDynamicLoop(),
    ms.postproc.RewriteParallelVectorizeUnroll(),
    ms.postproc.RewriteReductionBlock(),
    ms.postproc.RewriteTensorize(vectorize_init_loop=True),
]

def tune_and_test(relay_mod, data_np, weight_np, op_name, target, sch_rules, postprocs):
    """Test tuning."""
    tgt = "cuda" if "nvidia" in target else target
    dev = tvm.device(tgt, 0)
    ref = (
        relay.create_executor("vm", mod=relay_mod, device=dev, target=tgt)
        .evaluate()(*[data_np, weight_np])
        .numpy()
    )
    params = {"weight": weight_np}
    tune_tasks = list(
        filter(
            lambda task: op_name in task.task_name,
            ms.relay_integration.extract_tasks(relay_mod, target, params),
        )
    )
    with tempfile.TemporaryDirectory() as work_dir:
        tasks, task_weights = ms.relay_integration.extracted_tasks_to_tune_contexts(
            extracted_tasks=tune_tasks,
            work_dir=work_dir,
            space=ms.space_generator.PostOrderApply(
                sch_rules=sch_rules,
                postprocs=postprocs,
            ),
        )
        database = ms.tune.tune_tasks(
            tasks=tasks,
            task_weights=task_weights,
            work_dir=work_dir,
            max_trials_global=32,
        )
    with database, tvm.transform.PassContext(
        opt_level=3,
        config={"relay.backend.use_meta_schedule": True},
    ):
        lib = relay.build(relay_mod, target=target, params=params)

    if "cascadelake" in target:
        asm = lib.lib.get_source("asm")
        assert "vpdpbusd" in asm

    if "skylake-avx512" in target:
        asm = lib.lib.get_source("asm")
        assert "pmaddubs" in asm
        assert "pmaddw" in asm

    runtime = tvm.contrib.graph_executor.GraphModule(lib["default"](dev))
    runtime.set_input("data", data_np)
    runtime.run()
    out = runtime.get_output(0).numpy()
    np.testing.assert_equal(out, ref)

N = 1024

@T.prim_func
def before_tensorize(
    A: T.Buffer((N, N), "float32"),
    B: T.Buffer((N, N), "float32"),
    C: T.Buffer((N, N), "float32"),
) -> None:
    # with T.block("root")
    for i, j, k in T.grid(N, N, N):
        with T.block("update"):
            vi = T.axis.spatial(N, i)
            vj = T.axis.spatial(N, j)
            vk = T.axis.reduce(N, k)
            T.reads(C[vi, vj], A[vi, vk], B[vj, vk])
            T.writes(C[vi, vj])
            #with T.init():
            #    C[vi, vj] = T.float32(0)
            C[vi, vj] = C[vi, vj] + A[vi, vk] * B[vj, vk]


def apply_tensorize_rule():
    sched = tir.Schedule(before_tensorize)
    update = sched.get_block("update")
    rules = _get_schedule_rules_for_x86(AVX512_INTRIN)
    #sched.annotate(sched.get_block("root"), "pragma_import_c", vecinc_intrin_c())
    #i0 = sched.get_loops(update)
    #sched.split(i0[0], factors=[N//4, 4])

    scheds = rules[3].apply(sched, update)
    res = POSTPROCS_FOR_VNNI[3].apply(scheds[0])
    scheds[0].mod.show(black_format=True)

def _test_dense(data_dtype, sch_rules, postprocs, target):
    dim_m, dim_n, dim_k = 1024, 1024, 1024
    data_shape = (dim_m, dim_k)
    weight_shape = (dim_n, dim_k)

    weight_dtype = "int8"
    out_dtype = "int32"

    data = relay.var("data", shape=data_shape, dtype=data_dtype)
    weight = relay.var("weight", shape=weight_shape, dtype=weight_dtype)
    dense = relay.nn.dense(data, weight, out_dtype=out_dtype)

    relay_mod = tvm.IRModule.from_expr(dense)

    data_np = np.random.uniform(1, 10, size=data_shape).astype(data_dtype)
    weight_np = np.random.uniform(1, 10, size=weight_shape).astype(weight_dtype)

    tune_and_test(relay_mod, data_np, weight_np, "dense", target, sch_rules, postprocs)

apply_tensorize_rule()

 
SCH_RULES_FOR_AVX512 =_get_schedule_rules_for_x86(AVX512_INTRIN)
_test_dense("uint8", SCH_RULES_FOR_AVX512, POSTPROCS_FOR_VNNI, SKYLAKE_AVX512_TARGET)