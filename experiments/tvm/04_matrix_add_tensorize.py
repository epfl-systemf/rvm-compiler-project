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
        out: R.Tensor((128, 128), "float32") = R.add(a, b)
        return out

legalized_matmul = LegalizeOps()(Matmul)
legalized_matmul.show()

sched = tir.Schedule(legalized_matmul)
block = sched.get_block("T_add", func_name="add")
i,j = sched.get_loops(block)
i0, i1 = sched.split(i, [None, 16])
j0, j1 = sched.split(j, [None, 16])
sched.reorder(i0, j0, i1, j1)

@T.prim_func
def add_desc(a: T.handle, b: T.handle, c: T.handle) -> None:
    A = T.match_buffer(a, (16, 16), align=64, offset_factor=1)
    B = T.match_buffer(b, (16, 16), align=64, offset_factor=1)
    C = T.match_buffer(c, (16, 16), align=64, offset_factor=1)

    with T.block("root"):
        T.reads(A[0 : 16, 0 : 16], B[0 : 16, 0 : 16])
        T.writes(C[0 : 16, 0 : 16])
        for i, j in T.grid(16, 16):
            with T.block("T_add"):
                vi, vj = T.axis.remap("SS", [i, j])
                C[vi, vj] =  A[vi, vj] + B[vi, vj]

@T.prim_func
def add_intrin(a: T.handle, b: T.handle, c: T.handle) -> None:
    A = T.match_buffer(a, (16, 16), align=64, offset_factor=1)
    B = T.match_buffer(b, (16, 16), align=64, offset_factor=1)
    C = T.match_buffer(c, (16, 16), align=64, offset_factor=1)

    with T.block("root"):
        T.reads(A[0 : 16, 0 : 16], B[0 : 16, 0 : 16])
        T.writes(C[0 : 16, 0 : 16])
        T.call_extern("float32", "gemm", C.access_ptr("w"), A.access_ptr("r"), B.access_ptr("r"))
    
TensorIntrin.register("test_add_intrin", add_desc, add_intrin)

the_rule = ms.schedule_rule.MultiLevelTilingWithIntrin(
            "test_add_intrin",
            structure="SS",
            tile_binds=None,
            max_innermost_factor=64,
            vector_load_lens=None,
            reuse_read=None,
            reuse_write=None
        )

_, _, i1, _ = sched.get_loops(block)
sched.tensorize(i1, "test_add_intrin")
print(sched.mod["add"].show())
#for the_schedule in the_rule.apply(sched, ):
#    print(the_schedule.mod.show())


exit(0)
data_np = np.random.uniform(1, 10, (128,128)).astype("float32")
weight_np = np.random.uniform(1, 10, (128,128)).astype("float32")

tgt = "llvm"
dev = tvm.device(tgt,0)
params = {"weight": weight_np}
tune_tasks = list(
        ms.relay_integration.extract_tasks(legalized_matmul, tgt, params),
)

import tempfile

#ch_rules = [ms.schedule_rule.]

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
