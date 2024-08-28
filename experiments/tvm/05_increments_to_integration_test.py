import tempfile
import numpy as np
import pytest
import tvm
import tvm.testing
import tvm.topi.testing
from tvm import meta_schedule as ms
from tvm import relay
from tvm.meta_schedule.testing import relay_workload
#from tvm.tir.tensor_intrin.x86 import AVX512_DOT_16x4_INTRIN as AVX512_INTRIN

from tvm.script import tir as T
from tvm.tir import TensorIntrin
@T.prim_func
def my_intrin_desc(
    A: T.Buffer((16,16), "float32", offset_factor=1),
    B: T.Buffer((16,16), "float32", offset_factor=1),
    C: T.Buffer((16,16), "float32", offset_factor=1),
) -> None:
    with T.block("root"):
        T.reads(C[0:16,0:16], A[0:16, 0:16], B[0:16, 0:16])
        T.writes(C[0:16,0:16])
        for i,j,k in T.grid(16,16,16):
            with T.block("matmul"):
                vi, vj, vk = T.axis.remap("SSR", [i,j,k])
                C[vi,vj] = C[vi,vj] + A[vi,vk] + B[vj,vk]
        #for i in T.serial(0, 16):
        #    for k in T.serial(0, 4):
        #        with T.block("update"):
        #            vi, vk = T.axis.remap("SR", [i, k])
        #            C[vi] = C[vi] + T.cast(A[vk], "int32") * T.cast(B[vi, vk], "int32")

@T.prim_func
def my_intrin_impl(
    A: T.Buffer((16,16), "float32", offset_factor=1),
    B: T.Buffer((16,16), "float32", offset_factor=1),
    C: T.Buffer((16,16), "float32", offset_factor=1),
) -> None:
    with T.block("root"):
        T.reads(C[0:16,0:16], A[0:16, 0:16], B[0:16, 0:16])
        T.writes(C[0:16,0:16])
        #A_u8x4 = A.vload([0], "uint8x4")
        #A_i32 = T.reinterpret(A_u8x4, dtype="int32")
        #A_brdcst = T.broadcast(A_i32, 16)
        #A_u8x64 = T.reinterpret(A_brdcst, dtype="uint8x64")

        #B_i8x64 = B.vload([0, 0], dtype="int8x64")

        T.call_extern("int32", "gemm", C.access_ptr("w"), A.access_ptr("r"), B.access_ptr("r"))

        #Red = T.call_llvm_pure_intrin(
        #    T.llvm_lookup_intrinsic_id("llvm.x86.avx512.pmaddubs.w.512"),
        #    T.uint32(2),
        #    A_u8x64,
        #    B_i8x64,
        #    dtype="int16x32",
        #)
        
        #C[T.ramp(T.int32(0), 1, 16)] += T.call_llvm_pure_intrin(
        #    T.llvm_lookup_intrinsic_id("llvm.x86.avx512.pmaddw.d.512"),
        #    T.uint32(2),
        #    Red,
        #    T.int16x32(1),
        #    dtype="int32x16",
        #)

TensorIntrin.register("my_intrin", my_intrin_desc, my_intrin_impl)

SKYLAKE_AVX512_TARGET = "llvm -num-cores 4"

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

SCH_RULES_FOR_AVX512 = _get_schedule_rules_for_x86("my_intrin")
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

    asm = lib.lib.get_source("asm")
    print(asm)
    if "skylake-avx512" in target:
        asm = lib.lib.get_source("asm")
        assert "pmaddubs" in asm
        assert "pmaddw" in asm

    runtime = tvm.contrib.graph_executor.GraphModule(lib["default"](dev))
    runtime.set_input("data", data_np)
    runtime.run()
    out = runtime.get_output(0).numpy()
    np.testing.assert_equal(out, ref)

def _test_dense(data_dtype, sch_rules, postprocs, target):
    dim_m, dim_n, dim_k = 1024, 1024, 1024
    data_shape = (dim_m, dim_k)
    weight_shape = (dim_n, dim_k)

    weight_dtype = "float32"
    out_dtype = "float32"

    data = relay.var("data", shape=data_shape, dtype=data_dtype)
    weight = relay.var("weight", shape=weight_shape, dtype=weight_dtype)
    dense = relay.nn.dense(data, weight, out_dtype=out_dtype)

    relay_mod = tvm.IRModule.from_expr(dense)

    data_np = np.random.uniform(1, 10, size=data_shape).astype(data_dtype)
    weight_np = np.random.uniform(1, 10, size=weight_shape).astype(weight_dtype)

    tune_and_test(relay_mod, data_np, weight_np, "dense", target, sch_rules, postprocs)


if __name__ == "__main__":
    _test_dense("float32", SCH_RULES_FOR_AVX512, POSTPROCS_FOR_VNNI, SKYLAKE_AVX512_TARGET)