declare i64 @llvm.riscv.aes64ks1i(i64, i32);

define i64 @aes64ks1i(i64 %a) nounwind {
    %val = call i64 @llvm.riscv.aes64ks1i(i64 32, i32 10)
    ret i64 %val
}
