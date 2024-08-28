import numpy as np

import tvm
from tvm import te
from tvm import rpc
from tvm.contrib import utils

n = tvm.runtime.convert(1024)
A = te.placeholder((n,), name="A")
B = te.compute((n,), lambda i: A[i] + 1.0, name="B")
s = te.create_schedule(B.op)

local_demo = True

if local_demo:
    target = "llvm"
else:
    target = "llvm -mtriple=armv7l-linux-gnueabihf"

func = tvm.build(s, [A, B], target=target, name="add_one")
# save the lib at a local temp folder
temp = utils.tempdir()
path = temp.relpath("lib.tar")
func.export_library(path)

if local_demo:
    remote = rpc.LocalSession()
else:
    # The following is my environment, change this to the IP address of your target device
    host = "10.77.1.162"
    port = 9090
    remote = rpc.connect(host, port)

remote.upload(path)
func = remote.load_module("lib.tar")

# create arrays on the remote device
dev = remote.cpu()
dev2 = remote.cuda()
a = tvm.nd.array(np.random.uniform(size=1024).astype(A.dtype), dev)
b = tvm.nd.array(np.zeros(1024, dtype=A.dtype), dev2)
# the function will run on the remote device
func(a, b)
np.testing.assert_equal(b.numpy(), a.numpy() + 1)

time_f = func.time_evaluator(func.entry_name, dev, number=10)
cost = time_f(a, b).mean
print("%g secs/op" % cost)