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

N = 1024

@T.prim_func
def before_tensorize(
    A: T.Buffer((N, N), "float32"),
    B: T.Buffer((N, N), "float32"),
    C: T.Buffer((N, N), "float32"),
) -> None:
    # with T.block("root")
    for i_0, j_0, k_0, i_1, j_1, k_1 in T.grid(N//4, N//4, N//4, 4, 4, 4):
        with T.block("update"):
            vi = T.axis.spatial(N, i_0 * 4 + i_1)
            vj = T.axis.spatial(N, j_0 * 4 + j_1)
            vk = T.axis.reduce(N, k_0 * 4 + k_1)
            T.reads(C[vi, vj], A[vi, vk], B[vj, vk])
            T.writes(C[vi, vj])
            #with T.init():
            #    C[vi, vj] = T.float32(0)
            C[vi, vj] = C[vi, vj] + A[vi, vk] * B[vj, vk]


@T.prim_func
def mma_desc(a: T.handle, b: T.handle, c: T.handle) -> None:
    A = T.match_buffer(a, (4, 4), align=64, offset_factor=1)
    B = T.match_buffer(b, (4, 4), align=64, offset_factor=1)
    C = T.match_buffer(c, (4, 4), align=64, offset_factor=1)

    with T.block("root"):
        T.reads(C[0 : 4, 0 : 4], A[0 : 4, 0 : 4], B[0 : 4, 0 : 4])
        T.writes(C[0 : 4, 0 : 4])
        for i, j, k in T.grid(4, 4, 4):
            with T.block("C"):
                vi, vj, vk = T.axis.remap("SSR", [i, j, k])
#                with T.init():
#                    C[vi, vj] = T.float32(0)
                C[vi, vj] =  C[vi, vj] + A[vi, vk] * B[vj, vk]         



@T.prim_func
def mma_intrin(a: T.handle, b: T.handle, c: T.handle) -> None:
    s0 = T.int64()
    s1 = T.int64()

    A = T.match_buffer(a, (4, 4), align=64, offset_factor=1, strides=[s0,s1])
    B = T.match_buffer(b, (4, 4), align=64, offset_factor=1)
    C = T.match_buffer(c, (4, 4), align=64, offset_factor=1)

    with T.block("root"):
        T.reads(C[0 : 4, 0 : 4], A[0 : 4, 0 : 4], B[0 : 4, 0 : 4])
        T.writes(C[0 : 4, 0 : 4])
        T.call_llvm_intrin(
            "int32",
            "llvm.riscv.mcfg",
            T.uint32(1),
            T.int32(0x00100404),
        )
        T.call_llvm_intrin(
            "int32",
            "llvm.riscv.mld.w",
            T.uint32(2),
            T.int32(0),
            A.access_ptr("r"),
            T.int32(s0 << 2)
        )
        T.call_llvm_intrin(
            "int32",
            "llvm.riscv.mld.w",
            T.uint32(3),
            T.int32(1),
            B.access_ptr("r"),
            T.int32(s0 << 2)
        )
        T.call_llvm_intrin(
            "int32",
            "llvm.riscv.fmmacc.s",
            T.uint32(3),
            T.int32(2),
            T.int32(1),
            T.int32(0)
        )
        T.call_llvm_intrin(
            "int32",
            "llvm.riscv.mst.w",
            T.uint32(3),
            T.int32(2),
            C.access_ptr("w"),
            T.int32(s0 << 2)
        )

@T.prim_func
def tiled_thing(
    A: T.Buffer((512, 512), "float32"),
    B: T.Buffer((512, 512), "float32"),
    C: T.Buffer((512, 512), "float32"),
):
    T.func_attr({"global_symbol": "matmul_plain", "tir.noalias": T.bool(True)})
    # with T.block("root"):
    for (
        i_0_0,
        j_0_0,
        i_0_1,
        j_0_1,
        k_0_0,
        i_0_2,
        j_0_2,
        i_0_3,
        j_0_3,
        k_0_1,
    ) in T.grid(4, 2, 4, 1, 4, 1, 1, 8, 64, 32):
        with T.block("C_o"):
            v_i_o = T.axis.spatial(128, i_0_0 * 32 + i_0_1 * 8 + i_0_2 * 8 + i_0_3)
            v_j_o = T.axis.spatial(
                128, j_0_0 * 64 + j_0_1 * 64 + j_0_2 * 64 + j_0_3
            )
            v_k_o = T.axis.reduce(128, k_0_0 * 32 + k_0_1)
            T.reads(
                A[v_i_o * 4 : v_i_o * 4 + 4, v_k_o * 4 : v_k_o * 4 + 4],
                B[v_j_o * 4 : v_j_o * 4 + 4, v_k_o * 4 : v_k_o * 4 + 4],
            )
            T.writes(C[v_i_o * 4 : v_i_o * 4 + 4, v_j_o * 4 : v_j_o * 4 + 4])
            T.block_attr({"meta_schedule.auto_tensorize": "test_mma_intrin"})
            for i_1, j_1, k_1 in T.grid(4, 4, 4):
                with T.block("C"):
                    v_i_i, v_j_i, v_k_i = T.axis.remap("SSR", [i_1, j_1, k_1])
                    T.reads(
                        A[v_i_o * 4 + v_i_i, v_k_o * 4 + v_k_i],
                        B[v_j_o * 4 + v_j_i, v_k_o * 4 + v_k_i],
                    )
                    T.writes(C[v_i_o * 4 + v_i_i, v_j_o * 4 + v_j_i])
                    T.block_attr({"meta_schedule.tiling_structure": "SSRSSR"})
                    C[v_i_o * 4 + v_i_i, v_j_o * 4 + v_j_i] = (
                        C[v_i_o * 4 + v_i_i, v_j_o * 4 + v_j_i]
                        + A[v_i_o * 4 + v_i_i, v_k_o * 4 + v_k_i]
                        * B[v_j_o * 4 + v_j_i, v_k_o * 4 + v_k_i]
                    )

@T.prim_func
def matmul_plain(
    A: T.Buffer((512, 512), "float32"),
    B: T.Buffer((512, 512), "float32"),
    C: T.Buffer((512, 512), "float32"),
):
    T.func_attr({"tir.noalias": T.bool(True)})
    # with T.block("root"):
    for i, j, k in T.grid(512, 512, 512):
        with T.block("C"):
            v_i, v_j, v_k = T.axis.remap("SSR", [i, j, k])
            T.reads(C[v_i, v_j], A[v_i, v_k], B[v_j, v_k])
            T.writes(C[v_i, v_j])
            with T.init():
                C[v_i, v_j] = T.float32(0)
            C[v_i, v_j] = C[v_i, v_j] + A[v_i, v_k] * B[v_j, v_k]

TensorIntrin.register("test_mma_intrin", mma_desc, mma_intrin)

rules = [
    ms.schedule_rule.MultiLevelTilingWithIntrin(
        "test_mma_intrin",
        structure="SSRSSR",
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

sched = tir.Schedule(matmul_plain)
update = sched.get_block("C")
scheds = rules[0].apply(sched, update)
scheds[0].mod.show(black_format=True)
postprocs[0].apply(scheds[0])
print(scheds[0].trace)
scheds[0].mod.show(black_format=True)

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
    relay_mod.show()

    data_np = np.random.uniform(1, 10, size=data_shape).astype(data_dtype)
    weight_np = np.random.uniform(1, 10, size=weight_shape).astype(data_dtype)
    
    params = {"weight": weight_np}
    model_info = { 
        "in_tensor": "data",
        "in_shape": data_shape,
        "in_dtype": data_dtype,
    }
    return relay_mod, params, model_info

mod, params, model_info = create_relay_model()

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
            space = ms.space_generator.PostOrderApply(sch_rules = rules, postprocs=postprocs),
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