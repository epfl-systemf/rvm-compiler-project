; RUN: llc < %s -march=rv32imc_xtheadmatrix0p1  -verify-machineinstrs
define void @test_thead(ptr %A) {
  call void @llvm.riscv.mcfg(i32 1049604)
  call void @llvm.riscv.mld.w(i32 0, ptr %A, i32 16)
  call void @llvm.riscv.fmmacc.s(i32 0, i32 0, i32 0)
  call void @llvm.riscv.mst.w(i32 0, ptr %A, i32 16)
  ret void
}

;declare void @llvm.riscv.fmmacc.s(i32 %md, i32 %ms1, i32 %ms2)
;declare void @llvm.riscv.fmmacc.s(i32 %md, i32 %ms1, i32 %ms2)
