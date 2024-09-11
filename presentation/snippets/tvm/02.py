from tvm.script import ir as I, relax as R, tir as T
from tvm import tir
from tvm.tir import TensorIntrin

@T.prim_func
    def matmul(A: T.Buffer((128, 128), "float32"), B: T.Buffer((128, 128), "float32"), C: T.Buffer((128, 128), "float32")):
    # with T.block("root"):
    for i_0, j_0, k_0, i_1, j_1, k_1 in T.grid(32, 32, 32, 4, 4, 4):
        with T.block("update"):
            vi = T.axis.spatial(128, i_0 * 4 + i_1)
            vj = T.axis.spatial(128, j_0 * 4 + j_1)
            vk = T.axis.reduce(128, k_0 * 4 + k_1)
            T.reads(C[vi, vj], A[vi, vk], B[vj, vk])
            T.writes(C[vi, vj])
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
        T.call_extern("int", "matmul_4x4_update", 
            C.access_ptr("w"), A.access_ptr("r"), B.access_ptr("r"), s0)

def matmul_4x4_update():
    return """
    extern "C" int matmul_4x4_update(float *cc,float *aa,float *bb,int32_t stride) {
    asm volatile("mld.w m0, (%0), %3\\n\\r"  
        "mld.w m1, (%1), %3\\n\\r"
        "mld.w m2, (%2), %3\\n\\r"
        "fmmacc.s m2, m1, m0\\n\\r"
        "mst.w m2, (%2), %3\\n\\r" 
        :: "r"(aa), "r"(bb), "r"(cc), "r"(stride << 2));
    return 0; } """

TensorIntrin.register("test_mma_intrin", mma_spec, mma_intrin)
sched = tir.Schedule(matmul)
_, _, _, i1, _, _ = sched.get_loops(sched.get_block("update"))
# 'i1' refers to for i1 in .. loop
sched.annotate(sched.get_block("root"), "pragma_import_c", matmul_4x4_update())
sched.tensorize(i1, "test_mma_intrin")

sched.mod["main"].show(black_format=True)