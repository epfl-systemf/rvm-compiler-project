set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR riscv)

set(CMAKE_SYSROOT /opt/rvm_riscv/riscv32-unknown-elf/)

set(tools /opt/rvm_riscv/)
set(CMAKE_C_COMPILER ${tools}/bin/clang)
set(CMAKE_CXX_COMPILER ${tools}/bin/clang++)
set(CMAKE_C_FLAGS "-march=rv32imc_xtheadmatrix0p1 -menable-experimental-extensions")