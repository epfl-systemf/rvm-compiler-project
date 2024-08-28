import tvm
from tvm import meta_schedule as ms
from tvm.tir import schedule as sch
from tvm.relax.transform import LegalizeOps
from tvm.script import ir as I, relax as R, tir as T
from tvm.tir import TensorIntrin
from tvm import tir
from tvm.ir.module import IRModule


import numpy as np

@I.ir_module
class Matmul:
    @R.function
    def main(
        a: R.Tensor((128, 128), "float32"), b: R.Tensor((128, 128), "float32")
    ) -> R.Tensor((128, 128), "float32"):
        out: R.Tensor((128, 128), "float32") = R.matmul(a, b)
        return out
legalized_matmul = LegalizeOps()(Matmul)

@T.prim_func
def before_tensorize(
    A: T.Buffer((128, 128), "float32"),
    B: T.Buffer((128, 128), "float32"),
    C: T.Buffer((128, 128), "float32"),
) -> None:
    # body
    # with T.block("root")
    for i_0, j_0, k_0, i_1, j_1, k_1 in T.grid(8, 8, 8, 16, 16, 16):
        with T.block("matmul"):
            vi = T.axis.spatial(128, i_0 * 16 + i_1)
            vj = T.axis.spatial(128, j_0 * 16 + j_1)
            vk = T.axis.reduce(128, k_0 * 16 + k_1)
            T.writes(C[vi, vj])
            T.reads(A[vi, vk], B[vj, vk])
            #with T.init():
            #    C[vi, vj] = T.float32(0)
            C[vi, vj] = A[vi, vk] * B[vj, vk]


@T.prim_func
def mma_desc(a: T.handle, b: T.handle, c: T.handle) -> None:
    A = T.match_buffer(a, (16, 16), align=64, offset_factor=1)
    B = T.match_buffer(b, (16, 16), align=64, offset_factor=1)
    C = T.match_buffer(c, (16, 16), align=64, offset_factor=1)

    with T.block("root"):
        T.reads(A[0 : 16, 0 : 16], B[0 : 16, 0 : 16])
        T.writes(C[0 : 16, 0 : 16])
        for i, j, k in T.grid(16, 16, 16):
            with T.block("update"):
                vi, vj, vk = T.axis.remap("SSR", [i, j, k])
                # C[vi, vj] +
                C[vi, vj] =  A[vi, vk] * B[vj, vk]

def gemm_impl():
    asm_code = """
    /* Copied from matrix_insn.S in QEMU testcases */
    .text
    .align  2
    .global test_fmmacc_s_4x4
    .type   test_fmmacc_s_4x4, @function
    test_fmmacc_s_4x4:
        addi  t0,x0,0x10
        li t3, 0x00100404
        mcfg x0, t3

        mldw m0, t0, (a0)
        mldw m1, t0, (a1)

        li       t6,  0x00000010
        csrw xmcsr,t6

        fmmacc.s m2, m1, m0

        mstw m2, t0, (a3)

        ret
            .size   test_fmmacc_s_4x4, .-test_fmmacc_s_4x4

    """
    from tvm.contrib import utils, clang

    temp = utils.tempdir()
    ll_path = temp.relpath("temp.ll")
    # Create LLVM ir from c source code
    ll_code = clang.create_llvm(asm_code, output=ll_path)
    return ll_code              

@T.prim_func
def mma_intrin(a: T.handle, b: T.handle, c: T.handle) -> None:
    A = T.match_buffer(a, (16, 16), align=64, offset_factor=1)
    B = T.match_buffer(b, (16, 16), align=64, offset_factor=1)
    C = T.match_buffer(c, (16, 16), align=64, offset_factor=1)

    with T.block("root"):
        T.reads(A[0 : 16, 0 : 16], B[0 : 16, 0 : 16])
        T.writes(C[0 : 16, 0 : 16])
        T.call_extern("float32", "gemm", C.access_ptr("w"), A.access_ptr("r"), B.access_ptr("r"))

TensorIntrin.register("test_mma_intrin", mma_desc, mma_intrin)

sched = tir.Schedule(before_tensorize)
update = sched.get_block("matmul")
_, _, _, i1, _, _ = sched.get_loops(update)
sched.tensorize(i1, "test_mma_intrin")
print(sched.mod["main"].script())
m = sched.mod
print(m.script())

a = tvm.nd.array(np.random.uniform(1, 10, size=(128,128)).astype("float32"))
b = tvm.nd.array(np.random.uniform(1, 10, size=(128,128)).astype("float32"))
c = tvm.nd.array(np.zeros((128,128)).astype("float32"))

# target="c", runtime=tvm.relay.backend.Runtime("crt", {"system-lib": True})
func = tvm.build(m, target="llvm")
assert func
func(a,b,c)
#dev = tvm.cpu()
#from tvm.contrib import graph_executor
#m = graph_executor.GraphModule(func["before_tensorize"](dev))

#mod = tvm.build(IR_module, target="c") 