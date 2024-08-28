from onnx import TensorProto, numpy_helper
from onnx.helper import (
    make_model, make_node, make_graph,
    make_tensor_value_info)
from onnx.checker import check_model
import numpy as np

# inputs
bias = np.zeros(128,dtype=np.float32)
scale = np.ones(128,dtype=np.float32)

B = numpy_helper.from_array(bias, name='B')
S = numpy_helper.from_array(scale, name='S')

# 'X' is the name, TensorProto.FLOAT the type, [None, None] the
#  shape
X = make_tensor_value_info('X', TensorProto.FLOAT, [1,23,1024])
W = make_tensor_value_info('W', TensorProto.FLOAT, [128,23,3])

# outputs, the shape is left undefined

Y = make_tensor_value_info('Y', TensorProto.FLOAT, [None,None,None])

# nodes

# It creates a node defined by the operator type MatMul,
# 'X', 'A' are the inputs of the node, 'XA' the output.
node1 = make_node('Conv', ['X', 'W'], ['XW'], kernel_shape=[3], pads=[1])
node2 = make_node('BatchNormalization', ['XW', 'S', 'B', 'B', 'B'], ['BN'])
node3 = make_node('Relu', ['BN'], ['BNR'])
node4 = make_node('MaxPool', ['BNR'], ['Y'], kernel_shape=[4])

# from nodes to graph
# the graph is built from the list of nodes, the list of inputs,
# the list of outputs and a name.

graph = make_graph([node1,node2,node3,node4],  # nodes
                    'layer',  # a name
                    [X,W],  # inputs
                    [Y],    # outputs
                    [B,S])  

# onnx graph
# there is no metadata in this case.

onnx_model = make_model(graph)

# Let's check the model is consistent,
# this function is described in section
# Checker and Shape Inference.
check_model(onnx_model)

# the work is done, let's display it...
with open("model.onnx", "wb") as f:
    f.write(onnx_model.SerializeToString())