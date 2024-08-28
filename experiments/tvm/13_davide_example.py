import tvm
from tvm import relay

import numpy as np

# generate this using cmsis-nn
def create_relay_model():
    L = 1024
    in_channels = 23
    out_channels = 128
    kernel_size = 3

    data_dtype = "float32"
    # N C W   format 
    data_shape = (1, in_channels, L)
    # O I W   format
    weight_shape = (out_channels, in_channels, kernel_size)

    data = relay.var("data", shape=data_shape, dtype=data_dtype)
    weights = relay.var("weights", shape=weight_shape, dtype=data_dtype)

    conv = relay.nn.conv1d(data, weights, padding=1, channels=out_channels, kernel_size=3)

    gamma = relay.ones((out_channels), dtype=data_dtype)
    beta = relay.zeros((out_channels), dtype=data_dtype)
    moving_state = relay.zeros(data_shape, dtype=data_dtype)
    # relies on channels being dimension 1 of input
    #bn,_,_ = relay.nn.batch_norm(conv, gamma, beta, moving_state, moving_state)
    relu = relay.nn.relu(conv)
    pool = relay.nn.max_pool1d(relu, pool_size=4, padding=0)

    relay_mod = tvm.IRModule.from_expr(pool)

    weight_np = np.random.uniform(1, 10, size=weight_shape).astype(data_dtype)
    
    params = {"weights": weight_np}
    model_info = { 
        "in_tensor": "data",
        "in_shape": data_shape,
        "in_dtype": data_dtype,
    }
    return relay_mod, params, model_info

mod, params, model_info = create_relay_model()
target = tvm.target.Target("cmsis-nn,c -mcpu=cortex-m55")
runtime = relay.backend.Runtime("crt", {"system-lib": True})
#executor = Executor("aot", {"link-params": True})
with tvm.transform.PassContext(opt_level=3, config={
            "relay.ext.cmsisnn.options": {
                "mcpu": "cortex-m55",
            },
            "tir.usmp.enable": True,
            "tir.disable_storage_rewrite": True,
        }):
    lib = relay.build(mod, target, params=params)

