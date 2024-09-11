# RUN: python %s test 2>/dev/null
# 
# | FileCheck %s 
# ^^^ this doesn't seem to pass with lit for some reason

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
sched.mod["main"].show(style=None, black_format=False)
#CHECK: # from tvm.script import tir as T
#CHECK: @T.prim_func
#CHECK: def matmul(A: T.Buffer((128, 128), "float32"), B: T.Buffer((128, 128), "float32"), C: T.Buffer((128, 128), "float32")):
#CHECK:     with T.block("root"):
#CHECK:         T.reads()
#CHECK:         T.writes()
#CHECK:         T.block_attr({"pragma_import_c": metadata["runtime.String"][0]})
#CHECK:         for i_0, j_0, k_0 in T.grid(32, 32, 32):
#CHECK:             with T.block("update_o"):
#CHECK:                 vi_o, vj_o, vk_o = T.axis.remap("SSR", [i_0, j_0, k_0])
#CHECK:                 T.reads(C[vi_o * 4:vi_o * 4 + 4, vj_o * 4:vj_o * 4 + 4], A[vi_o * 4:vi_o * 4 + 4, vk_o * 4:vk_o * 4 + 4], B[vj_o * 4:vj_o * 4 + 4, vk_o * 4:vk_o * 4 + 4])
#CHECK:                 T.writes(C[vi_o * 4:vi_o * 4 + 4, vj_o * 4:vj_o * 4 + 4])
#CHECK:                 A_1 = T.match_buffer(A[vi_o * 4:vi_o * 4 + 4, vk_o * 4:vk_o * 4 + 4], (4, 4), strides=("A_s0", "A_s1"), offset_factor=1)
#CHECK:                 B_1 = T.match_buffer(B[vj_o * 4:vj_o * 4 + 4, vk_o * 4:vk_o * 4 + 4], (4, 4), offset_factor=1)
#CHECK:                 C_1 = T.match_buffer(C[vi_o * 4:vi_o * 4 + 4, vj_o * 4:vj_o * 4 + 4], (4, 4), offset_factor=1)
#CHECK:                 T.call_extern("int32", "matmul_4x4_update", T.tvm_access_ptr(T.type_annotation("float32"), C_1.data, C_1.elem_offset, 16, 2), T.tvm_access_ptr(T.type_annotation("float32"), A_1.data, A_1.elem_offset, T.Cast("int64", A_1.strides[0]) * T.int64(4), 1), T.tvm_access_ptr(T.type_annotation("float32"), B_1.data, B_1.elem_offset, 16, 1), A_1.strides[0])
#CHECK: # Metadata omitted. Use show_meta=True in script() method to show it.


import sys
if "test" not in sys.argv:
    func = tvm.build(m, target="c")
    with open("out/tvm_out.h", 'w') as f:
        f.write(func.get_source())