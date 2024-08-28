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

from tvm.contrib import graph_executor, utils
from tvm.contrib.micro.meta_schedule.local_builder_micro import get_local_builder_micro
from tvm.contrib.micro.meta_schedule.rpc_runner_micro import get_rpc_runner_micro

import os
import numpy as np

def vecinc_intrin_c():
    return f"""
extern "C" int thing(float *aa, float *bb, float *cc) {{
    for (int i = 0; i < 4; i++) {{
        cc[i] = aa[i] + bb[i];
    }}
    asm volatile("fmmacc.s m2, m1, m0\\n\\r");
    return 0;
}}
    """

N = 64

@T.prim_func
def before_tensorize(
    A: T.Buffer((N), "float32"),
    B: T.Buffer((N), "float32"),
    C: T.Buffer((N), "float32"),
) -> None:
    with T.block("root"):
        for i_0 in T.grid(N):
            with T.block("update"):
                vi = T.axis.spatial(N, i_0)
                T.reads(A[vi],B[vi])
                T.writes(C[vi])
                C[vi] = A[vi] + B[vi]

@T.prim_func
def vecinc_desc(
    A: T.Buffer((4,), "float32", offset_factor=1),
    B: T.Buffer((4,), "float32", offset_factor=1),
    C: T.Buffer((4,), "float32", offset_factor=1),
) -> None:

    with T.block("root"):
        T.reads(A[0 : 4],B[0 : 4])
        T.writes(C[0 : 4])
        for i in T.grid(4):
            with T.block("update"):
                vi = T.axis.remap("S", [i])
                C[vi] = A[vi] + B[vi]

@T.prim_func
def vecinc_intrin(
    A: T.Buffer((4,), "float32", offset_factor=1),
    B: T.Buffer((4,), "float32", offset_factor=1),
    C: T.Buffer((4,), "float32", offset_factor=1),
) -> None:

    with T.block("root"):
        T.reads(A[0 : 4],B[0:4])
        T.writes(C[0 : 4])
        T.call_extern("int", "thing", C.access_ptr("w"), A.access_ptr("r"), B.access_ptr("r"))

TensorIntrin.register("test_vecinc_intrin", vecinc_desc, vecinc_intrin)

###################################
# Test manual tensorization first #
###################################

sched = tir.Schedule(before_tensorize)
update = sched.get_block("update")

i0 = sched.get_loops(update)
sched.split(i0[0], factors=[N//4, 4])
print("---- After Split ----")
sched.mod.show(black_format=True)

sched.annotate(sched.get_block("root"), "pragma_import_c", vecinc_intrin_c())
print("---- After Import ----")
sched.mod.show(black_format=True)

_, i1= sched.get_loops(update)
sched.tensorize(i1, "test_vecinc_intrin")
print("---- After Tensorize ----")
sched.mod.show(black_format=True)

#######################
# Semi auto-tensorize #
#######################
rules = [
    ms.schedule_rule.MultiLevelTilingWithIntrin(
        "test_vecinc_intrin",
        structure="S",
        tile_binds=None,
        max_innermost_factor=64,
        vector_load_lens=None,
        reuse_read=None,
        reuse_write=None
    ),
    ms.schedule_rule.ParallelizeVectorizeUnroll(
        max_jobs_per_core=-1,
        max_vectorize_extent=64,
        unroll_max_steps=None,
        unroll_explicit=False,
    ),
]

postprocs = [
    ms.postproc.RewriteTensorize(),
    ms.postproc.RewriteParallelVectorizeUnroll()
]

sched = tir.Schedule(before_tensorize)
update = sched.get_block("update")
#sched.annotate(sched.get_block("root"), "pragma_import_c", vecinc_intrin_c())
i0 = sched.get_loops(update)
#sched.split(i0[0], factors=[N//64, 64])

sched.vectorize(i0[0])

scheds = rules[1].apply(sched, update)
print(scheds[0].trace)
res = postprocs[1].apply(scheds[0])
print(scheds[0].trace)
sched.mod.show(black_format=True)

exit(0)
#################
# Autotensorize #
#################

def create_relay_model():
    dim_m, dim_n, dim_k = 1024, 1024, 1024
    data_shape = (dim_m, dim_k)
    weight_shape = (dim_n, dim_k)

    data_dtype = "float32"

    data = relay.var("data", shape=data_shape, dtype=data_dtype)
    weight = relay.var("weight", shape=weight_shape, dtype=data_dtype)
    dense = relay.nn.dense(data, weight, out_dtype=data_dtype)

    relay_mod = tvm.IRModule.from_expr(dense)

    data_np = np.random.uniform(1, 10, size=data_shape).astype(data_dtype)
    weight_np = np.random.uniform(1, 10, size=weight_shape).astype(data_dtype)
    


mod, params, model_info = create_relay_module()

platform = "riscv"
project_options = {
    "verbose": False,
    "toolchain_file": os.path.abspath("tvm/thead_clang_toolchain_file.cmake")
}

target = tvm.target.Target("c")
runtime = relay.backend.Runtime("crt", {"system-lib": True})
executor = Executor("aot", {"link-params": True})
# This line is necessary for link-params to take effect during
# task extraction and relay.build(...).
mod = mod.with_attr("executor", executor)
builder = get_local_builder_micro()
work_dir = utils.tempdir()

with ms.Profiler() as profiler:
    with get_rpc_runner_micro(
        platform=platform,
        options=project_options,
        session_timeout_sec=120,
        serial_numbers=["0"],
    ) as runner:

        db: ms.Database = ms.relay_integration.tune_relay(
            mod=mod,
            params=params,
            target=target,
            builder=builder,
            runner=runner,
            strategy="evolutionary",
            num_trials_per_iter=2,
            max_trials_per_task=10,
            max_trials_global=100,
            work_dir=work_dir.path,
            module_equality="ignore-ndarray",
            space = ms.space_generator.PostOrderApply(sch_rules = rules),
        )

    #  Build model using meta_schedule logs
    opt_mod, opt_params = relay.optimize(mod, target)
    ms_mod: tvm.runtime.Module = ms.relay_integration.compile_relay(
        database=db,
        mod=opt_mod,
        target=target,
        params=opt_params,
        pass_config=MappingProxyType(
            {
                "relay.backend.use_meta_schedule": True,
                "relay.backend.tir_converter": "default",
                "tir.disable_vectorize": True,
            }
        ),
        executor=executor,
        runtime=runtime,
    )
print(profiler.table())

proj = tvm.micro.generate_project(
    str(tvm.micro.get_microtvm_template_projects(platform)),
    ms_mod,
    "/tmp/project",
    options=project_options,
)
proj.build()