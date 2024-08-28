import tvm
from tvm import meta_schedule as ms
from tvm import relay
from tvm.script import tir as T
from tvm.tir.tensor_intrin.x86 import dot_product_16x4_u8i8i32_vnni

print("??")

A_buf = tvm.tir.decl_buffer((4,), "uint8", "A")
B_buf = tvm.tir.decl_buffer((16, 4), "int8", "B")
C_buf = tvm.tir.decl_buffer((16,), "int32", "C")

target = "llvm -mcpu=skylake-avx512"
f = tvm.build(dot_product_16x4_u8i8i32_vnni, [A_buf, B_buf, C_buf], name="my_thing", target=target)

print(f.get_source())