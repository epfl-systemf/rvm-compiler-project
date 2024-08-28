set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR riscv)

set(CMAKE_SYSROOT /opt/xuantie-riscv-toolchain/sysroot)

set(tools /opt/xuantie-riscv-toolchain/)
set(CMAKE_C_COMPILER ${tools}/bin/riscv64-unknown-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER ${tools}/bin/riscv64-unknown-linux-gnu-g++)
set(CMAKE_C_FLAGS "-march=rv64gcv0p7_zfh_xtheadc_xtheadmatrix -mabi=lp64d")