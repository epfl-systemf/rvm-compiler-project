import torch
import torch.nn as nn
import torch.nn.functional as F
from torch import func

L = 1024
in_channels = 23
n_filters = 128
kernel_size = 3

class SimpleLayer(nn.Module):

    def __init__(self):
        super(SimpleLayer, self).__init__()
        self.conv = nn.Conv1d(in_channels, n_filters, kernel_size=kernel_size, padding=1)
        self.bn = nn.BatchNorm1d(n_filters)
        self.pool = nn.MaxPool1d(kernel_size=4, padding=0)
        self.bn.train(False)

    def forward(self, x):
        x = self.conv(x)
        x = func.functionalize(self.bn)(x)
        x = self.pool(F.relu(x))
        return x

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.conv1 = nn.Conv2d(in_channels=1, out_channels=10,
                               kernel_size=5,
                               stride=1)
        self.conv2 = nn.Conv2d(10, 20, kernel_size=5)
        self.conv2_bn = nn.BatchNorm2d(20)
        self.dense1 = nn.Linear(in_features=320, out_features=50)
        self.dense1_bn = nn.BatchNorm1d(50)
        self.dense2 = nn.Linear(50, 10)
        

    def forward(self, x):
        x = F.relu(F.max_pool2d(self.conv1(x), 2))
        x = F.relu(F.max_pool2d(self.conv2_bn(self.conv2(x)), 2))
        x = x.view(-1, 320) #reshape
        x = F.relu(self.dense1_bn(self.dense1(x)))
        x = F.relu(self.dense2(x))
        return F.log_softmax(x)
    


torch_model = Net()
torch_input = torch.randn(1, 1, 16, 160)
onnx_program = torch.onnx.dynamo_export(torch_model, torch_input)

onnx_program.save("davide_test.onnx")