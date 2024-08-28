#%%

from __future__ import absolute_import, print_function


import tvm
from tvm import te
import tvm.testing
import numpy as np

from tvm.relay.backend import Executor, Runtime
#%%

N, M, L = 1024, 512, 64
A = te.placeholder((N, L), name="A")
B = te.placeholder((M, L), name="B")
k = te.reduce_axis((0, L), name="k")
C = te.compute((N, M), lambda i, j: te.sum(A[i, k] * B[j, k], axis=k), name="C")
s = te.create_schedule(C.op)
print(tvm.lower(s, [A, B, C], simple_mode=True))


#%%

factor = 16
x, y = C.op.axis
(z,) = C.op.reduce_axis
yo, yi = s[C].split(y, factor=factor)
s[C].reorder(x, yo, yi, z)
print(tvm.lower(s, [A, B, C], simple_mode=True))

#%%

def intrin_gemv(m, l):
    a = te.placeholder((l,), name="a")
    b = te.placeholder((m, l), name="b")
    k = te.reduce_axis((0, l), name="k")
    c = te.compute((m,), lambda i: te.sum(a[k] * b[i, k], axis=k), name="c")
    Ab = tvm.tir.decl_buffer(a.shape, a.dtype, name="A", offset_factor=1, strides=[1])
    Bb = tvm.tir.decl_buffer(b.shape, b.dtype, name="B", offset_factor=1, strides=[te.var("s1"), 1])
    Cb = tvm.tir.decl_buffer(c.shape, c.dtype, name="C", offset_factor=1, strides=[1])

    def intrin_func(ins, outs):
        ib = tvm.tir.ir_builder.create()
        aa, bb = ins
        cc = outs[0]
        ib.emit(
            tvm.tir.call_extern(
                "int32",
                "gemv_update",
                cc.access_ptr("w"),
                aa.access_ptr("r"),
                bb.access_ptr("r"),
                m,
                l,
                bb.strides[0],
            )
        )
        return ib.get()

    return te.decl_tensor_intrin(c.op, intrin_func, binds={a: Ab, b: Bb, c: Cb})

#%%

def gemv_impl():
    cc_code = """
      extern "C" int gemv_update(float *cc, float *aa, float *bb, int m, int l, int stride) {
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < l; ++j) {
                cc[i] += aa[j] * bb[i * stride + j];
            }
        }
        return 0;
      }
    """
    from tvm.contrib import utils, clang

    temp = utils.tempdir()
    ll_path = temp.relpath("temp.ll")
    # Create LLVM ir from c source code
    ll_code = clang.create_llvm(cc_code, output=ll_path)
    return ll_code

#%%

gemv = intrin_gemv(factor, L)
s[C].pragma(x, "import_llvm", gemv_impl())
s[C].tensorize(yi, gemv)
module1 = tvm.lower(s, [A, B, C], simple_mode=True)
print(module1)
# %%

func = tvm.build(s, [A, B, C], target="c -device=arm_cpu", name="gemv", runtime=Runtime("crt"))
file_path = 'tvm_test.c'
with open(file_path, "w") as f:
  f.write(func.get_source())

#%%
  
from tvm.driver.tvmc.model import TVMCModel
from tvm.driver.tvmc.compiler import compile_model


model = TVMCModel(module1, {})
compile_model(tvmc_model=model,
                  target="c -device=arm_cpu",
                  executor=Executor("aot",
                                    {"interface-api": "c",
                                     "unpacked-api": 1}
                                    ),
                  runtime=Runtime("crt"),
                  output_format="mlf",
                  package_path="model.tar")
# %%
