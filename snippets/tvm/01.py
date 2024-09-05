from tvm.script import ir as I, relax as R, tir as T
from tvm import tir

N = 128
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
    

sched = tir.Schedule(matmul)
i, j, k = sched.get_loops(sched.get_block("update"))
i0, i1 = sched.split(i, factors=[None, 4])
j0, j1 = sched.split(j, factors=[None, 4])
k0, k1 = sched.split(k, factors=[None, 4])
sched.reorder(i0, j0, k0, i1, j1, k1)

sched.mod["main"].show(black_format=True)