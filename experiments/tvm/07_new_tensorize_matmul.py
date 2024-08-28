import tvm
from tvm import meta_schedule as ms
from tvm.tir import schedule as sch
from tvm.relax.transform import LegalizeOps
from tvm.script import ir as I, relax as R, tir as T
from tvm.tir import TensorIntrin
from tvm import tir
from tvm.ir.module import IRModule

N = 128

import numpy as np

"""
for (int i = 0; i < 4; i++) {{
        for (int j = 0; j < 4; j++) {{
            float acc = cc[stride*i+j];
            for (int k = 0; k < 4; k++) {{
                acc += aa[stride*i + k] * bb[stride*j + k];
            }}
            cc[stride*i + j] = acc; //acc;
        }}
    }}
    return 0;
"""

def matmul_4x4_update():
    return f"""
extern "C" int matmul_4x4_update(float *cc, float *aa, float *bb, int32_t stride) {{
    int32_t stride_adj = stride << 2;
    asm volatile(                      
        "mld.w m0, (%0), %3\\n\\r"  
        "mld.w m1, (%1), %3\\n\\r"
        "mld.w m2, (%2), %3\\n\\r"
        "fmmacc.s m2, m1, m0\\n\\r"
        "mst.w m2, (%2), %3\\n\\r"
        :                                                                      
        : "r"(aa), "r"(bb), "r"(cc), "r"(stride_adj));
    return 0;
}}
    """

@T.prim_func
def matmul(
    A: T.Buffer((N, N), "float32"),
    B: T.Buffer((N, N), "float32"),
    C: T.Buffer((N, N), "float32"),
) -> None:
    for i,j,k in T.grid(N, N, N):
        with T.block("update"):
            vi = T.axis.spatial(N, i)
            vj = T.axis.spatial(N, j)
            vk = T.axis.reduce(N, k)
            C[vi, vj] = C[vi, vj] + A[vi, vk] * B[vj, vk]


@T.prim_func
def mma_spec(a: T.handle, b: T.handle, c: T.handle) -> None:
    A = T.match_buffer(a, (4, 4), align=64, offset_factor=1)
    B = T.match_buffer(b, (4, 4), align=64, offset_factor=1)
    C = T.match_buffer(c, (4, 4), align=64, offset_factor=1)

    with T.block("root"):
        T.reads(C[0 : 4, 0 : 4], A[0 : 4, 0 : 4], B[0 : 4, 0 : 4])
        T.writes(C[0 : 4, 0 : 4])
        for i, j, k in T.grid(4, 4, 4):
            with T.block("update"):
                vi, vj, vk = T.axis.remap("SSR", [i, j, k])
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
        T.call_extern("int", "matmul_4x4_update", C.access_ptr("w"), A.access_ptr("r"), B.access_ptr("r"), s0)



TensorIntrin.register("test_mma_intrin", mma_spec, mma_intrin)

sched = tir.Schedule(matmul)

i, j, k = sched.get_loops(sched.get_block("update"))
i0, i1 = sched.split(i, factors=[None, 4])
j0, j1 = sched.split(j, factors=[None, 4])
k0, k1 = sched.split(k, factors=[None, 4])

sched.reorder(i0, j0, k0, i1, j1, k1)
sched.annotate(sched.get_block("root"), "pragma_import_c", matmul_4x4_update())
sched.tensorize(i1, "test_mma_intrin")

m = sched.mod
#print(sched.mod["main"].script())
##sched.annotate(sched.get_block("update_o"), )
#dev = tvm.cpu()
#npA = np.random.uniform(1, 10, size=(128,128)).astype("float32")
## np.identity(N).astype("float32")
#npB = np.random.uniform(1, 10, size=(128,128)).astype("float32")
## np.identity(N).astype("float32")
#npC = np.zeros((N,N)).astype("float32")
#a = tvm.nd.array(npA, dev)
#b = tvm.nd.array(npB, dev)
#c = tvm.nd.array(npC, dev)

from tvm.contrib import cc
# target="c", runtime=tvm.relay.backend.Runtime("crt", {"system-lib": True})
func = tvm.build(m, target="c")
with open("out/tvm_out.h", 'w') as f:
    f.write(func.get_source())
exit(0)
func.export_library("matmul.tar")#, fcompile=cc.cross_compiler("/opt/rvm_riscv/bin/clang++", ["-march=rv32imc_xtheadmatrix0p1","-menable-experimental-extensions","-I/home/julien/tvm/include/","-I/home/julien/tvm/3rdparty/dlpack/include/"]))
lib = tvm.runtime.load_module("matmul.so")
lib["before_tensorize"](a,b,c)
res = c
ref = np.matmul(npA, npB.transpose())
print(res, ref)

#from tvm.contrib import graph_executor
#m = graph_executor.GraphModule(func["before_tensorize"](dev))

#mod = tvm.build(IR_module, target="c") 


#def gemm_impl():
#    asm_code = """
#    /* Copied from matrix_insn.S in QEMU testcases */
#    .text
#    .align  2
#    .global test_fmmacc_s_4x4
#    .type   test_fmmacc_s_4x4, @function
#    test_fmmacc_s_4x4:
#        addi  t0,x0,0x10
#        li t3, 0x00100404
#        mcfg x0, t3
#
#        mldw m0, t0, (a0)
#        mldw m1, t0, (a1)
#
#        li       t6,  0x00000010
#        csrw xmcsr,t6
#
#        fmmacc.s m2, m1, m0
#
#        mstw m2, t0, (a3)
#
#        ret
#            .size   test_fmmacc_s_4x4, .-test_fmmacc_s_4x4
#
#    """
#    from tvm.contrib import utils, clang
#
#    temp = utils.tempdir()
#    ll_path = temp.relpath("temp.ll")
#    # Create LLVM ir from c source code
#    ll_code = clang.create_llvm(asm_code, output=ll_path)
#    return ll_code     