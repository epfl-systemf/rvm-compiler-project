set -e
python3 tvm/07_new_tensorize_matmul.py
$RISCV/bin/clang++ \
    -Os \
    -Wall -Werror -Wno-unused-variable -Wno-ignored-attributes \
    -march=rv32imc_xtheadmatrix0p1 -menable-experimental-extensions \
    -I/home/julien/tvm/include/ -I/home/julien/tvm/3rdparty/dlpack/include/ \
    tvm/07_tvm_manual_intf.cc -o out/07.elf
spike  --isa=RV32IMC_xmatrix  pk -s out/07.elf