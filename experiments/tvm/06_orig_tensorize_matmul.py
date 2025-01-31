# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
"""
.. _tutorials-tensorize:

Use Tensorize to Leverage Hardware Intrinsics
=============================================
**Author**: `Yizhi Liu <https://github.com/yzhliu>`_

This is an introduction material on how to perform tensorization in TVM.

By using schedule primitive :code:`tensorize`,
people can replace a unit of computation with the corresponding intrinsics,
making it easy to leverage handcrafted micro-kernels,
as well as extend TVM to support new hardware architectures.

The purpose of this tutorial is to show the functionality
and usage of tensorize instead of providing an efficient solution.

"""
from __future__ import absolute_import, print_function


import tvm
from tvm import te
import tvm.testing
import numpy as np

######################################################################
# Define Matrix Multiplication
# ----------------------------
# Take matrix multiplication as our example.
# Matmul first multiply the corresponding elements between two matrix,
# then accumulate across a certain axis.
# The following lines describe the computation :code:`A * B^T` in TVM.
#
N, M, L = 1024, 512, 16
A = te.placeholder((N, L), name="A")
B = te.placeholder((M, L), name="B")
k = te.reduce_axis((0, L), name="k")
C = te.compute((N, M), lambda i, j: te.sum(A[i, k] * B[j, k], axis=k), name="C")
s = te.create_schedule(C.op)
tvm.lower(s, [A, B, C], simple_mode=True).show(black_format=True)
print(A.shape[0])

######################################################################
# Schedule the Matmul
# -------------------
# Now, suppose we have an accelerator that supports
# matrix-vector multiplication (GEMV) as a hardware primitive,
# which can take arbitrary size of reduce axis,
# but another axis needs to be no larger than 16.
# Thus we break down the matmul loops to make the innermost loops a (16x64) GEMV.
#
factor = 4
x, y = C.op.axis
(z,) = C.op.reduce_axis
yo, yi = s[C].split(y, factor=factor)
xo, xi = s[C].split(x, factor=factor)
zo, zi = s[C].split(z, factor=factor)
s[C].reorder(xo, yo, zo, xi, yi, zi)
print(tvm.lower(s, [A, B, C], simple_mode=True))

######################################################################
# As showed in the IR printed above,
# the inner loops :code:`j.inner` along with :code:`k` together form a computation of GEMV
# - within the inner most two loops, the index :code:`i` is fixed,
# the access to the matrix :code:`A` only varies by :code:`k`,
# which makes the access pattern of :code:`A` a "vector".
# In order to leverage our hypothetical hardware's GEMV instruction,
# we can tensorize over :code:`j.inner`.
#
# Define GEMV Tensorization Intrinsic
# -----------------------------------
# Before scheduling the tensorization, we need to first define the intrinsic function for GEMV.
# It includes two parts, the first is a compute definition of GEMV.
# TVM uses it to match the computing pattern in the original Matmul schedule.
# The second is to specify how to execute GEMV on the device,
# which is done in :code:`intrin_func` below.
#
def intrin_gemv(abs, cs):
    n = 4
    a = te.placeholder((n,n), name="a")
    b = te.placeholder((n,n), name="b")
    k = te.reduce_axis((0,n), name="k")
    c = te.compute((n,n), lambda i, j: te.sum(a[i, k] * b[j, k], axis=k), name="c")
    #, strides=[m, 1]
    #, strides=[m, 1]
    #, strides=[n, 1]
    Ab = tvm.tir.decl_buffer(a.shape, a.dtype, name="AA", offset_factor=1, strides=[abs, 1]) 
    Bb = tvm.tir.decl_buffer(b.shape, b.dtype, name="BB", offset_factor=1, strides=[abs, 1])
    Cb = tvm.tir.decl_buffer(c.shape, c.dtype, name="CC", offset_factor=1, strides=[cs, 1])

    s2 = te.create_schedule(c.op)
    print(tvm.lower(s2, [a, b, c], simple_mode=True))

    def intrin_func(ins, outs):
        aa, bb = ins
        cc = outs[0]
        def _body():
            ib = tvm.tir.ir_builder.create()
            ib.emit(
                tvm.tir.call_extern(
                    "int32",
                    "matmul_4x4_update",
                    cc.access_ptr("w"),
                    aa.access_ptr("r"),
                    bb.access_ptr("r"),
                    abs,
                    cs
                )
            )
            return ib.get()
        
        def _reduce_update():
            return _body()
        
        def _reduce_reset():
            ib = tvm.tir.ir_builder.create()
            ib.emit(tvm.tir.call_extern("int32", "matmul_4x4_reset"))
            return ib.get()
        
        return _body(), _reduce_reset(), _reduce_update()

    return te.decl_tensor_intrin(c.op, intrin_func, binds={a: Ab, b: Bb, c: Cb})


######################################################################
# Here :code:`te.decl_tensor_intrin` declares how to execute the computation :code:`c.op`.
# Our implementation simply takes the inputs and outputs,
# converts them to pointers and emit an external function call.
# Note that tensorization requires user to specify :code:`offset_factor`,
# with this information, TVM has knowledge of whether the data is aligned
# between the start address of the original data structure
# and the offset being passed to tensorize,
# so that it has chance to optimize with vectorized loading.
# We set the factor to 1 for simplification.
#
# Buffers are also declared for inputs and outputs, though this is not required,
# we benefit from the extra information provided by buffers. For example, we pass
# :code:`bb.strides[0]` as an argument to the external function :code:`gemv_update`.
# For now :code:`bb.strides[0] == l`,
# but later we will see how they can differ with more complicated schedules.
#
# Note that we use :code:`te.var("s1")` as the first stride dimension for :code:`B`.
# If the strides can be inferred
# - in this case, TVM knows tensor B is compact thus the strides are :code:`[L, 1]` -
# such placeholder can be put to let TVM automatically bind the inferred value for us.
#
gemv = intrin_gemv(L, M)
s[C].tensorize(xi, gemv)
tvm.lower(s, [A, B, C], simple_mode=True).show(black_format=True)

######################################################################
# By tensorizing over :code:`yi`, the inner most two loops are
# now replaced by the intrinsic function we defined before.
# In order to build and run the module, let's define the external function :code:`gemv_update`,
# it is a naive implementation of GEMV, just for demonstration.
#

# "mldw m2, %4, (%2)\\n\\r"                                         
def matmul_4x4_update():
    return """
    extern "C" int matmul_4x4_update(float *cc, float *aa, float *bb, int abs, int cs) {
        asm("li t3, 0x00100404"\n\r
            "mcfg t3"\n\r                                                      
            "mld.w m0, (%0), %3"\n\r                                                
            "mld.w m1, (%1), %3"\n\r          
            "fmmacc.s m2, m1, m0"\n\r                                              
            "mst.w m2, %4, (%2)"\n\r                                                
            :                                                                      
            : "r"(aa), "r"(bb), "r"(cc), "r"(abs), "r"(cs));
        return 0;
    }
    // extern "C" 
    int matmul_4x4_reset() {
        asm("mzero m2");
        return 0;
    }
    """


######################################################################
# Now we leverage the pragma attribute :code:`import_llvm` to import llvm asm inline.
# The importing needs to happen before the tensorized GEMV being executed.
#
from tvm.relay.backend import Runtime
s[C].pragma(xo, "import_c", matmul_4x4_update())
lowered = tvm.lower(s, [A, B, C], simple_mode=True)
#gf = GraphExecutorFactoryModule(
#    ir_mod = lowered,
#    target = "c",
#    executor = None,
#    graph_json_str = """{
#        
#    }""",
#
#)


func = tvm.build(s, [A, B, C], target="c", name="gemv") # , runtime=Runtime("crt", {"system-lib": True}) 
print(type(func))
print(func.get_source())

######################################################################
# Finally we compare the tensorize version with that :code:`numpy.dot` produces,
# ensure our implementation is correct.
#
from tvm import micro
from tvm import rpc
import os.path

from tvm import relay

def create_relay_module():
    data_shape = (1, 3, 16, 16)
    weight_shape = (8, 3, 5, 5)
    data = relay.var("data", relay.TensorType(data_shape, "float32"))
    weight = relay.var("weight", relay.TensorType(weight_shape, "float32"))
    y = relay.nn.conv2d(
        data,
        weight,
        padding=(2, 2),
        kernel_size=(5, 5),
        kernel_layout="OIHW",
        out_dtype="float32",
    )
    f = relay.Function([data, weight], y)
    mod = tvm.IRModule.from_expr(f)
    mod = relay.transform.InferType()(mod)

    weight_sample = np.random.rand(
        weight_shape[0], weight_shape[1], weight_shape[2], weight_shape[3]
    ).astype("float32")
    params = {mod["main"].params[1].name_hint: weight_sample}

    

    return mod, params


#mod = tvm.IRModule() 
#mod.update_func(func)
#model_info = {
#    "in_tensor": "A",
#    "in_shape": (N,L),
#    "in_dtype": "float32",
#}
#weight_sample = np.random.uniform(size=get_const_tuple(B.shape)).astype(B.dtype)
#params = {mod["main"].params[1].name_hint: weight_sample}

#mod,params = create_relay_module()

#RUNTIME = Runtime("crt", {"system-lib": True})
#TARGET = "c"
#pass_context = tvm.transform.PassContext(opt_level=3, config={"tir.disable_vectorize": True})
#with pass_context:
#    lowered = tvm.relay.build(lowered, target=TARGET, runtime=RUNTIME, params=params)
#print(type(lowered))

#proj = micro.generate_project(
#    str(tvm.micro.get_microtvm_template_projects("riscv")),
#    func,
#    "/tmp/project",
#    {
#    "verbose": False,
#    "toolchain_file": os.path.abspath("tvm/thead_toolchain_file.cmake")
#    }
#)
#proj.build()
#print(lowered.get_graph_json())
#with open("out/matmul.c", 'w') as f:
#    f.write(func.get_source())
from tvm.contrib import cc
from tvm.topi.utils import get_const_tuple
# , 
#func.export_library("matmul.so", fcompile=cc.cross_compiler("/opt/xuantie-riscv-toolchain/bin/riscv64-unknown-linux-gnu-g++", ["-march=rv64gcv0p7_zfh_xtheadc_xtheadmatrix","-mabi=lp64d"]))
func.export_library("matmul.tar", fcompile=cc.cross_compiler("/opt/rvm_riscv/bin/clang", ["-march=rv32imc_xtheadmatrix0p1","-menable-experimental-extensions","-I/home/julien/tvm/include/","-I/home/julien/tvm/3rdparty/dlpack/include/"]))
exit(0)
#host = "127.0.0.1"
#port = 9090
#remote = rpc.connect(host,port)
#remote.upload("matmul.so")
#func = remote.load_module("matmul.so")

#transport = tvm.
with micro.Session(proj.transport()) as session:
    thing = session.create_aot_executor()
    print(type(thing))
    dev = session.device

    dtype = A.dtype
    a = np.random.uniform(size=get_const_tuple(A.shape)).astype(dtype)
    b = np.random.uniform(size=get_const_tuple(B.shape)).astype(dtype)
    c = tvm.nd.array(np.zeros(get_const_tuple(C.shape), dtype=dtype), dev)

    thing["gemv"](tvm.nd.array(a, dev), tvm.nd.array(b, dev), c)

    
    #debug_module = tvm.micro.create_local_debug_executor(
    #     lowered.get_graph_json(), session.get_system_lib(), session.device
    #)
    #debug_module.set_input(**lowered.get_params())
    #print("########## Build without Autotuning ##########")
    #debug_module.run()
    #del debug_module
dev = remote.cpu()
#func = session.get_system_lib()
#


#
func["gemv"](tvm.nd.array(a, dev), tvm.nd.array(b, dev), c)
#func
#tvm.testing.assert_allclose(c.numpy(), np.dot(a, b.T), rtol=1e-3)

######################################################################
# Reduce-update for Tensorize
# ---------------------------
# So far you have learned the basic idea of tensorize,
# now let's move one step forward to a more complicated case.
#
# Assume our accelerator could only multiply a vector by a square matrix,
# in which the vector size needs to be no larger than 16.
# Given such hardware constrain, now we need to split the reduce axis as following,
#
#zo, zi = s[C].split(z, factor=factor)
#s[C].reorder(x, yo, zo, yi, zi)

######################################################################
# However, since the tensorize intrinsic now only covers a part of the reduce axis,
# instead of using one "body" function, TVM requires a :code:`reduce_reset` function,
# which will be invoked before the reduce for-loop, and a :code:`reduce_update` function,
# which defines the "update" computing strategy.
#
#def gemv_impl():
#    cc_code = """
#      extern "C" int gemv_update(float *cc, float *aa, float *bb, int m, int l, int stride) {
#        for (int i = 0; i < m; ++i) {
#            for (int j = 0; j < l; ++j) {
#                cc[i] += aa[j] * bb[i * stride + j];
#            }
#        }
#        return 0;
#      }
#      extern "C" int gemv_reset(float *cc, int m) {
#        for (int i = 0; i < m; ++i) {
#            cc[i] = 0.0;
#        }
#        return 0;
#      }
#    """
#    from tvm.contrib import utils, clang
#
#    temp = utils.tempdir()
#    ll_path = temp.relpath("temp.ll")
#    # Create LLVM ir from c source code
#    ll_code = clang.create_llvm(cc_code, output=ll_path)
#    return ll_code
#
#
#def intrin_gemv(m, l):
#    a = te.placeholder((l,), name="a")
#    b = te.placeholder((m, l), name="b")
#    k = te.reduce_axis((0, l), name="k")
#    c = te.compute((m,), lambda i: te.sum(a[k] * b[i, k], axis=k), name="c")
#    Ab = tvm.tir.decl_buffer(a.shape, a.dtype, name="A", offset_factor=1, strides=[1])
#    Bb = tvm.tir.decl_buffer(b.shape, b.dtype, name="B", offset_factor=1, strides=[te.var("s1"), 1])
#    Cb = tvm.tir.decl_buffer(c.shape, c.dtype, name="C", offset_factor=1, strides=[1])
#
#    def intrin_func(ins, outs):
#        aa, bb = ins
#        cc = outs[0]
#
#        def _body():
#            ib = tvm.tir.ir_builder.create()
#            ib.emit(
#                tvm.tir.call_extern(
#                    "int32",
#                    "gemv_update",
#                    cc.access_ptr("w"),
#                    aa.access_ptr("r"),
#                    bb.access_ptr("r"),
#                    m,
#                    l,
#                    bb.strides[0],
#                )
#            )
#            return ib.get()
#
#        def _reduce_reset():
#            ib = tvm.tir.ir_builder.create()
#            ib.emit(tvm.tir.call_extern("int32", "gemv_reset", cc.access_ptr("w"), m))
#            return ib.get()
#
#        def _reduce_update():
#            return _body()
#
#        return _body(), _reduce_reset(), _reduce_update()
#
#    return te.decl_tensor_intrin(c.op, intrin_func, binds={a: Ab, b: Bb, c: Cb})
#
#
#######################################################################
## Note that :code:`intrin_func` now returns a triplet:
## :code:`(body, reduce_reset, reduce_update)`.
## If tensorization includes all the reduce axes, function :code:`body()` will be invoked,
## otherwise :code:`reduce_reset()` and :code:`reduce_update()` together will be used.
## In our example :code:`body()` and :code:`reduce_update()`
## share the same implementation,
## while in other cases, hardware may have different instructions for these two functions.
## Moreover, we can see now :code:`bb.strides[0]` is different from :code:`l`
## due to the tiling.
##
## Tensorize for squared GEMV, build and check the results,
##
#gemv = intrin_gemv(factor, factor)
#s[C].tensorize(yi, gemv)
#s[C].pragma(yo, "import_llvm", gemv_impl())
#
#func = tvm.build(s, [A, B, C], target="llvm", name="gemv")
#a = np.random.uniform(size=get_const_tuple(A.shape)).astype(dtype)
#b = np.random.uniform(size=get_const_tuple(B.shape)).astype(dtype)
#c = tvm.nd.array(np.zeros(get_const_tuple(C.shape), dtype=dtype), dev)
#func(tvm.nd.array(a, dev), tvm.nd.array(b, dev), c)
#tvm.testing.assert_allclose(c.numpy(), np.dot(a, b.T), rtol=1e-3)
#
#######################################################################
## Summary
## -------
## This tutorial demonstrates the usage of tensorize intrinsic in TVM.
## Tensorize provides a way for users to get fully optimized schedule via micro-kernels.
## For example, INT8 quantization on Intel CPUs uses tensorization
## to invoke AVX instruction directly.
## It also enables TVM to compile to ASICs -
## checkout :ref:`vta-index` for details.
## We also demonstrates how to use inline assembly importing,
## which helps users inject asm easily into the schedule.
##
#
