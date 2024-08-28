	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_xtheadmatrix0p1"
	.file	"TVMMod"
	.globl	before_tensorize                # -- Begin function before_tensorize
	.p2align	2
	.type	before_tensorize,@function
before_tensorize:                       # @before_tensorize
.Lfunc_begin0:
	.file	1 "." "IRModule.CodeGenLLVM"
	.loc	1 0 0                           # IRModule.CodeGenLLVM:0:0
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
.Ltmp0:
	sw	a0, 24(sp)
	sw	a1, 20(sp)
	sw	a2, 16(sp)
	sw	a3, 12(sp)
	sw	a4, 8(sp)
	li	t6, 3
	sw	a5, 4(sp)
	bne	a2, t6, .LBB0_56
# %bb.1:                                # %assert_end
	lw	t5, 0(a1)
.Ltmp1:
	#DEBUG_VALUE: before_tensorize:A_handle.code <- [$x30+0]
	lw	t4, 4(a1)
.Ltmp2:
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	lw	t0, 0(a0)
.Ltmp3:
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lw	t3, 8(a1)
.Ltmp4:
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	lw	a5, 8(a0)
.Ltmp5:
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lw	a1, 16(a0)
.Ltmp6:
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lw	t2, 20(t0)
.Ltmp7:
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	lw	t1, 24(t0)
.Ltmp8:
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	lw	a2, 8(t0)
.Ltmp9:
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	lw	a7, 20(a5)
.Ltmp10:
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	lw	a6, 24(a5)
.Ltmp11:
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	lw	a0, 0(a1)
.Ltmp12:
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	lw	a4, 20(a1)
.Ltmp13:
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	lw	a3, 24(a1)
.Ltmp14:
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	beq	t5, t6, .LBB0_5
.Ltmp15:
# %bb.2:                                # %assert_end
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	#DEBUG_VALUE: before_tensorize:A_handle.code <- [$x30+0]
	li	t6, 13
	beq	t5, t6, .LBB0_5
.Ltmp16:
# %bb.3:                                # %assert_end
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	#DEBUG_VALUE: before_tensorize:A_handle.code <- [$x30+0]
	li	t6, 7
	beq	t5, t6, .LBB0_5
.Ltmp17:
# %bb.4:                                # %assert_end
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	#DEBUG_VALUE: before_tensorize:A_handle.code <- [$x30+0]
	li	t6, 4
	bne	t5, t6, .LBB0_55
.Ltmp18:
.LBB0_5:                                # %assert_end2
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	#DEBUG_VALUE: before_tensorize:A_handle.code <- [$x30+0]
	li	t5, 3
.Ltmp19:
	beq	t4, t5, .LBB0_9
.Ltmp20:
# %bb.6:                                # %assert_end2
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	li	t6, 13
	beq	t4, t6, .LBB0_9
.Ltmp21:
# %bb.7:                                # %assert_end2
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	li	t6, 7
	beq	t4, t6, .LBB0_9
.Ltmp22:
# %bb.8:                                # %assert_end2
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	li	t6, 4
	bne	t4, t6, .LBB0_57
.Ltmp23:
.LBB0_9:                                # %assert_end4
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	beq	t3, t5, .LBB0_13
.Ltmp24:
# %bb.10:                               # %assert_end4
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	li	t4, 13
.Ltmp25:
	beq	t3, t4, .LBB0_13
.Ltmp26:
# %bb.11:                               # %assert_end4
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	li	t4, 7
	beq	t3, t4, .LBB0_13
.Ltmp27:
# %bb.12:                               # %assert_end4
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	li	t4, 4
	bne	t3, t4, .LBB0_58
.Ltmp28:
.LBB0_13:                               # %assert_end6
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lw	t4, 12(t0)
	li	t3, 2
.Ltmp29:
	bne	t4, t3, .LBB0_52
.Ltmp30:
# %bb.14:                               # %assert_end8
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lw	t4, 12(t0)
	bne	t4, t3, .LBB0_52
.Ltmp31:
# %bb.15:                               # %assert_end10
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lbu	t3, 16(t0)
	li	t4, 2
	bne	t3, t4, .LBB0_59
.Ltmp32:
# %bb.16:                               # %assert_end10
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lbu	t3, 17(t0)
	li	t4, 32
	bne	t3, t4, .LBB0_59
.Ltmp33:
# %bb.17:                               # %assert_end10
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lhu	t3, 18(t0)
	li	t4, 1
	bne	t3, t4, .LBB0_59
.Ltmp34:
# %bb.18:                               # %assert_end12
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lw	t4, 0(t2)
	li	t3, 16
	bne	t4, t3, .LBB0_60
.Ltmp35:
# %bb.19:                               # %assert_end14
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lw	t2, 8(t2)
.Ltmp36:
	bne	t2, t3, .LBB0_61
.Ltmp37:
# %bb.20:                               # %assert_end16
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	beqz	t1, .LBB0_23
.Ltmp38:
# %bb.21:                               # %if_then
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lw	t2, 8(t1)
	li	t3, 1
	bne	t2, t3, .LBB0_63
.Ltmp39:
# %bb.22:                               # %if_then
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lw	t1, 0(t1)
.Ltmp40:
	li	t2, 16
	bne	t1, t2, .LBB0_63
.Ltmp41:
.LBB0_23:                               # %if_end
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lw	t1, 36(t0)
	lw	t2, 32(t0)
	or	t1, t2, t1
	bnez	t1, .LBB0_62
.Ltmp42:
# %bb.24:                               # %assert_end20
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lw	t0, 4(t0)
.Ltmp43:
	li	t1, 1
	bne	t0, t1, .LBB0_64
.Ltmp44:
# %bb.25:                               # %assert_end22
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lw	t1, 12(a5)
	li	t0, 2
	bne	t1, t0, .LBB0_53
.Ltmp45:
# %bb.26:                               # %assert_end24
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lw	t1, 12(a5)
	bne	t1, t0, .LBB0_53
.Ltmp46:
# %bb.27:                               # %assert_end26
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lbu	t0, 16(a5)
	li	t1, 2
	bne	t0, t1, .LBB0_65
.Ltmp47:
# %bb.28:                               # %assert_end26
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lbu	t0, 17(a5)
	li	t1, 32
	bne	t0, t1, .LBB0_65
.Ltmp48:
# %bb.29:                               # %assert_end26
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lhu	t0, 18(a5)
	li	t1, 1
	bne	t0, t1, .LBB0_65
.Ltmp49:
# %bb.30:                               # %assert_end28
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lw	t1, 0(a7)
	li	t0, 16
	bne	t1, t0, .LBB0_66
.Ltmp50:
# %bb.31:                               # %assert_end30
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lw	a7, 8(a7)
.Ltmp51:
	bne	a7, t0, .LBB0_67
.Ltmp52:
# %bb.32:                               # %assert_end32
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	beqz	a6, .LBB0_35
.Ltmp53:
# %bb.33:                               # %if_then33
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lw	a7, 8(a6)
	li	t0, 1
	bne	a7, t0, .LBB0_69
.Ltmp54:
# %bb.34:                               # %if_then33
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lw	a6, 0(a6)
.Ltmp55:
	li	a7, 16
	bne	a6, a7, .LBB0_69
.Ltmp56:
.LBB0_35:                               # %if_end34
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lw	a6, 36(a5)
	lw	a7, 32(a5)
	or	a6, a7, a6
	bnez	a6, .LBB0_68
.Ltmp57:
# %bb.36:                               # %assert_end38
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lw	a6, 4(a5)
	li	a7, 1
	bne	a6, a7, .LBB0_70
.Ltmp58:
# %bb.37:                               # %assert_end40
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lw	a5, 8(a5)
.Ltmp59:
	bne	a2, a5, .LBB0_71
.Ltmp60:
# %bb.38:                               # %assert_end42
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lw	a6, 12(a1)
	li	a5, 2
	bne	a6, a5, .LBB0_54
.Ltmp61:
# %bb.39:                               # %assert_end44
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lw	a6, 12(a1)
	bne	a6, a5, .LBB0_54
.Ltmp62:
# %bb.40:                               # %assert_end46
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lbu	a5, 16(a1)
	li	a6, 2
	bne	a5, a6, .LBB0_72
.Ltmp63:
# %bb.41:                               # %assert_end46
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lbu	a5, 17(a1)
	li	a6, 32
	bne	a5, a6, .LBB0_72
.Ltmp64:
# %bb.42:                               # %assert_end46
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lhu	a5, 18(a1)
	li	a6, 1
	bne	a5, a6, .LBB0_72
.Ltmp65:
# %bb.43:                               # %assert_end48
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lw	a6, 0(a4)
	li	a5, 16
	bne	a6, a5, .LBB0_73
.Ltmp66:
# %bb.44:                               # %assert_end50
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lw	a4, 8(a4)
.Ltmp67:
	bne	a4, a5, .LBB0_74
.Ltmp68:
# %bb.45:                               # %assert_end52
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	beqz	a3, .LBB0_48
.Ltmp69:
# %bb.46:                               # %if_then53
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lw	a4, 8(a3)
	li	a5, 1
	bne	a4, a5, .LBB0_76
.Ltmp70:
# %bb.47:                               # %if_then53
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lw	a3, 0(a3)
.Ltmp71:
	li	a4, 16
	bne	a3, a4, .LBB0_76
.Ltmp72:
.LBB0_48:                               # %if_end54
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lw	a3, 36(a1)
	lw	a4, 32(a1)
	or	a3, a4, a3
	bnez	a3, .LBB0_75
.Ltmp73:
# %bb.49:                               # %assert_end58
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lw	a3, 4(a1)
	li	a4, 1
	bne	a3, a4, .LBB0_77
.Ltmp74:
# %bb.50:                               # %assert_end60
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lw	a1, 8(a1)
.Ltmp75:
	bne	a2, a1, .LBB0_78
.Ltmp76:
# %bb.51:                               # %assert_end62
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	call	before_tensorize_compute_
.Ltmp77:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.LBB0_52:                               # %assert_fail7
.Ltmp78:
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp79:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp80:
	lui	a0, %hi(.L.str.4)
	addi	a0, a0, %lo(.L.str.4)
	j	.LBB0_79
.Ltmp81:
.LBB0_53:                               # %assert_fail23
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp82:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp83:
	lui	a0, %hi(.L.str.11)
	addi	a0, a0, %lo(.L.str.11)
	j	.LBB0_79
.Ltmp84:
.LBB0_54:                               # %assert_fail43
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp85:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp86:
	lui	a0, %hi(.L.str.19)
	addi	a0, a0, %lo(.L.str.19)
	j	.LBB0_79
.Ltmp87:
.LBB0_55:                               # %assert_fail1
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	#DEBUG_VALUE: before_tensorize:A_handle.code <- [$x30+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp88:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp89:
	lui	a0, %hi(.L.str.1)
	addi	a0, a0, %lo(.L.str.1)
	j	.LBB0_79
.Ltmp90:
.LBB0_56:                               # %assert_fail
	lui	a0, %hi(__TVMAPISetLastError)
	lw	a1, %lo(__TVMAPISetLastError)(a0)
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	j	.LBB0_79
.LBB0_57:                               # %assert_fail3
.Ltmp91:
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	#DEBUG_VALUE: before_tensorize:B_handle.code <- [$x29+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp92:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp93:
	lui	a0, %hi(.L.str.2)
	addi	a0, a0, %lo(.L.str.2)
	j	.LBB0_79
.Ltmp94:
.LBB0_58:                               # %assert_fail5
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:C_handle.code <- [$x28+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp95:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp96:
	lui	a0, %hi(.L.str.3)
	addi	a0, a0, %lo(.L.str.3)
	j	.LBB0_79
.Ltmp97:
.LBB0_59:                               # %assert_fail11
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp98:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp99:
	lui	a0, %hi(.L.str.5)
	addi	a0, a0, %lo(.L.str.5)
	j	.LBB0_79
.Ltmp100:
.LBB0_60:                               # %assert_fail13
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.shape <- [$x7+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp101:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp102:
	lui	a0, %hi(.L.str.6)
	addi	a0, a0, %lo(.L.str.6)
	j	.LBB0_79
.Ltmp103:
.LBB0_61:                               # %assert_fail15
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.A_handle.strides <- [$x6+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp104:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp105:
	lui	a0, %hi(.L.str.7)
	addi	a0, a0, %lo(.L.str.7)
	j	.LBB0_79
.Ltmp106:
.LBB0_62:                               # %assert_fail19
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp107:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp108:
	lui	a0, %hi(.L.str.9)
	addi	a0, a0, %lo(.L.str.9)
	j	.LBB0_79
.Ltmp109:
.LBB0_63:                               # %assert_fail17
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	#DEBUG_VALUE: before_tensorize:A_handle <- [$x5+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp110:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp111:
	lui	a0, %hi(.L.str.8)
	addi	a0, a0, %lo(.L.str.8)
	j	.LBB0_79
.Ltmp112:
.LBB0_64:                               # %assert_fail21
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp113:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp114:
	lui	a0, %hi(.L.str.10)
	addi	a0, a0, %lo(.L.str.10)
	j	.LBB0_79
.Ltmp115:
.LBB0_65:                               # %assert_fail27
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp116:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp117:
	lui	a0, %hi(.L.str.12)
	addi	a0, a0, %lo(.L.str.12)
	j	.LBB0_79
.Ltmp118:
.LBB0_66:                               # %assert_fail29
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.shape <- [$x17+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp119:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp120:
	lui	a0, %hi(.L.str.13)
	addi	a0, a0, %lo(.L.str.13)
	j	.LBB0_79
.Ltmp121:
.LBB0_67:                               # %assert_fail31
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.B_handle.strides <- [$x16+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp122:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp123:
	lui	a0, %hi(.L.str.14)
	addi	a0, a0, %lo(.L.str.14)
	j	.LBB0_79
.Ltmp124:
.LBB0_68:                               # %assert_fail37
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp125:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp126:
	lui	a0, %hi(.L.str.16)
	addi	a0, a0, %lo(.L.str.16)
	j	.LBB0_79
.Ltmp127:
.LBB0_69:                               # %assert_fail35
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp128:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp129:
	lui	a0, %hi(.L.str.15)
	addi	a0, a0, %lo(.L.str.15)
	j	.LBB0_79
.Ltmp130:
.LBB0_70:                               # %assert_fail39
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	#DEBUG_VALUE: before_tensorize:B_handle <- [$x15+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp131:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp132:
	lui	a0, %hi(.L.str.17)
	addi	a0, a0, %lo(.L.str.17)
	j	.LBB0_79
.Ltmp133:
.LBB0_71:                               # %assert_fail41
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp134:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp135:
	lui	a0, %hi(.L.str.18)
	addi	a0, a0, %lo(.L.str.18)
	j	.LBB0_79
.Ltmp136:
.LBB0_72:                               # %assert_fail47
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp137:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp138:
	lui	a0, %hi(.L.str.20)
	addi	a0, a0, %lo(.L.str.20)
	j	.LBB0_79
.Ltmp139:
.LBB0_73:                               # %assert_fail49
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.shape <- [$x14+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp140:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp141:
	lui	a0, %hi(.L.str.21)
	addi	a0, a0, %lo(.L.str.21)
	j	.LBB0_79
.Ltmp142:
.LBB0_74:                               # %assert_fail51
	#DEBUG_VALUE: before_tensorize:before_tensorize.C_handle.strides <- [$x13+0]
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp143:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp144:
	lui	a0, %hi(.L.str.22)
	addi	a0, a0, %lo(.L.str.22)
	j	.LBB0_79
.Ltmp145:
.LBB0_75:                               # %assert_fail57
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp146:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp147:
	lui	a0, %hi(.L.str.24)
	addi	a0, a0, %lo(.L.str.24)
	j	.LBB0_79
.Ltmp148:
.LBB0_76:                               # %assert_fail55
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp149:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp150:
	lui	a0, %hi(.L.str.23)
	addi	a0, a0, %lo(.L.str.23)
	j	.LBB0_79
.Ltmp151:
.LBB0_77:                               # %assert_fail59
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	#DEBUG_VALUE: before_tensorize:C_handle <- [$x11+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp152:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
.Ltmp153:
	lui	a0, %hi(.L.str.25)
	addi	a0, a0, %lo(.L.str.25)
	j	.LBB0_79
.Ltmp154:
.LBB0_78:                               # %assert_fail61
	#DEBUG_VALUE: before_tensorize:C <- [$x10+0]
	#DEBUG_VALUE: before_tensorize:dev_id <- [$x12+0]
	lui	a0, %hi(__TVMAPISetLastError)
.Ltmp155:
	lw	a1, %lo(__TVMAPISetLastError)(a0)
	lui	a0, %hi(.L.str.26)
	addi	a0, a0, %lo(.L.str.26)
.Ltmp156:
.LBB0_79:                               # %assert_fail
	jalr	a1
	li	a0, -1
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Ltmp157:
.Lfunc_end0:
	.size	before_tensorize, .Lfunc_end0-before_tensorize
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function before_tensorize_compute_
	.type	before_tensorize_compute_,@function
before_tensorize_compute_:              # @before_tensorize_compute_
.Lfunc_begin1:
	.loc	1 0 0                           # IRModule.CodeGenLLVM:0:0
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	li	a1, 0
.Ltmp158:
	sw	a0, 12(sp)
	li	a2, 3
	lui	a3, 256
	addi	a3, a3, 1028
	li	a4, 64
	j	.LBB1_2
.LBB1_1:                                # %for_end_j_0
                                        #   in Loop: Header=BB1_2 Depth=1
	addi	a1, a1, 1
.LBB1_2:                                # %for_begin_i_0
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_5 Depth 2
                                        #       Child Loop BB1_7 Depth 3
	blt	a2, a1, .LBB1_8
# %bb.3:                                # %for_body_i_0
                                        #   in Loop: Header=BB1_2 Depth=1
	li	a5, 0
	slli	a6, a1, 6
	j	.LBB1_5
.LBB1_4:                                # %for_end_k_0
                                        #   in Loop: Header=BB1_5 Depth=2
	addi	a5, a5, 1
.LBB1_5:                                # %for_begin_j_0
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_7 Depth 3
	blt	a2, a5, .LBB1_1
# %bb.6:                                # %for_body_j_0
                                        #   in Loop: Header=BB1_5 Depth=2
	li	a7, 0
	slli	t0, a5, 2
	add	t0, a6, t0
	slli	t0, t0, 2
	add	t0, a0, t0
	bltz	a2, .LBB1_4
.LBB1_7:                                # %for_body_k_0
                                        #   Parent Loop BB1_2 Depth=1
                                        #     Parent Loop BB1_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
.Ltmp159:
	#DEBUG_VALUE: before_tensorize_compute_:cse_var_1 <- undef
	mcfg	a3
	mld.w	m2, (t0), a4
	mst.w	m2, (t0), a4
	fmmacc.s	m2, m0, m1
	mst.w	m2, (t0), a4
	addi	a7, a7, 1
	bge	a2, a7, .LBB1_7
	j	.LBB1_4
.Ltmp160:
.LBB1_8:                                # %for_end_i_0
	li	a0, 0
	addi	sp, sp, 16
	ret
.Ltmp161:
.Lfunc_end1:
	.size	before_tensorize_compute_, .Lfunc_end1-before_tensorize_compute_
	.cfi_endproc
                                        # -- End function
	.p2align	2                               # -- Begin function __tvm_module_startup
	.type	__tvm_module_startup,@function
__tvm_module_startup:                   # @__tvm_module_startup
.Lfunc_begin2:
	.cfi_startproc
# %bb.0:                                # %entry
	ret
.Lfunc_end2:
	.size	__tvm_module_startup, .Lfunc_end2-__tvm_module_startup
	.cfi_endproc
                                        # -- End function
	.section	.text.tvm.fp16.conv,"ax",@progbits
	.weak	__truncsfhf2                    # -- Begin function __truncsfhf2
	.p2align	2
	.type	__truncsfhf2,@function
__truncsfhf2:                           # @__truncsfhf2
.Lfunc_begin3:
	.cfi_startproc
# %bb.0:                                # %b0
	slli	a1, a0, 1
	srli	a1, a1, 1
	lui	a2, 817152
	add	a2, a1, a2
	lui	a3, 755712
	add	a3, a1, a3
	bgeu	a2, a3, .LBB3_4
# %bb.1:                                # %b1
	lui	a2, 16
	addi	a2, a2, -1
	srli	a3, a0, 13
	and	a1, a3, a2
	slli	a4, a0, 19
	srli	a4, a4, 19
	lui	a5, 1
	addi	a7, a5, 1
	lui	a6, 1048548
	bltu	a4, a7, .LBB3_6
# %bb.2:                                # %b2
	addi	a6, a6, 1
	add	a1, a1, a6
.LBB3_3:                                # %b13
	srli	a0, a0, 31
	slli	a0, a0, 15
	or	a0, a1, a0
	ret
.LBB3_4:                                # %b5
	lui	a2, 522240
	addi	a2, a2, 1
	bltu	a1, a2, .LBB3_8
# %bb.5:                                # %b6
	slli	a1, a0, 10
	srli	a1, a1, 23
	lui	a2, 8
	addi	a2, a2, -512
	or	a1, a1, a2
	srli	a0, a0, 31
	slli	a0, a0, 15
	or	a0, a1, a0
	ret
.LBB3_6:                                # %b3
	add	a1, a1, a6
	bne	a4, a5, .LBB3_3
# %bb.7:                                # %b4
	and	a1, a1, a2
	andi	a3, a3, 1
	add	a1, a1, a3
	srli	a0, a0, 31
	slli	a0, a0, 15
	or	a0, a1, a0
	ret
.LBB3_8:                                # %b7
	srli	a2, a1, 23
	li	a3, 142
	bgeu	a3, a2, .LBB3_10
# %bb.9:
	li	a1, 31
	slli	a1, a1, 10
	srli	a0, a0, 31
	slli	a0, a0, 15
	or	a0, a1, a0
	ret
.LBB3_10:                               # %b8
	srli	a1, a1, 24
	li	a3, 45
	bgeu	a1, a3, .LBB3_12
# %bb.11:
	srli	a0, a0, 31
	slli	a0, a0, 15
	or	a0, zero, a0
	ret
.LBB3_12:                               # %b9
	li	a1, 113
	sub	a1, a1, a2
	slli	a3, a0, 9
	srli	a3, a3, 9
	lui	a4, 2048
	or	a3, a3, a4
	addi	a2, a2, -81
	sll	a2, a3, a2
	snez	a2, a2
	srl	a1, a3, a1
	slli	a3, a1, 19
	srli	a3, a3, 19
	or	a2, a3, a2
	lui	a3, 1
	addi	a4, a3, 1
	srli	a1, a1, 13
	bltu	a2, a4, .LBB3_14
# %bb.13:                               # %b10
	addi	a1, a1, 1
	srli	a0, a0, 31
	slli	a0, a0, 15
	or	a0, a1, a0
	ret
.LBB3_14:                               # %b11
	bne	a2, a3, .LBB3_3
# %bb.15:                               # %b12
	andi	a2, a1, 1
	add	a1, a2, a1
	srli	a0, a0, 31
	slli	a0, a0, 15
	or	a0, a1, a0
	ret
.Lfunc_end3:
	.size	__truncsfhf2, .Lfunc_end3-__truncsfhf2
	.cfi_endproc
                                        # -- End function
	.weak	__extendhfsf2                   # -- Begin function __extendhfsf2
	.p2align	2
	.type	__extendhfsf2,@function
__extendhfsf2:                          # @__extendhfsf2
.Lfunc_begin4:
	.cfi_startproc
# %bb.0:                                # %b0
	slli	a1, a0, 17
	srli	a1, a1, 17
	addi	a2, a1, -1024
	slli	a2, a2, 16
	srli	a2, a2, 27
	li	a3, 14
	bltu	a3, a2, .LBB4_2
# %bb.1:                                # %b1
	slli	a1, a1, 13
	lui	a2, 229376
	add	a1, a1, a2
	j	.LBB4_11
.LBB4_2:                                # %b2
	srli	a2, a1, 10
	li	a3, 31
	bltu	a2, a3, .LBB4_4
# %bb.3:                                # %b3
	slli	a1, a1, 13
	lui	a2, 522240
	or	a1, a1, a2
	j	.LBB4_11
.LBB4_4:                                # %b4
	beqz	a1, .LBB4_11
# %bb.5:                                # %b5
	sltiu	a2, a1, 256
	xori	a2, a2, 1
	slli	a2, a2, 3
	srl	a3, a1, a2
	sltiu	a2, a3, 16
	xori	a5, a2, 1
	li	a6, 256
	li	a4, 32
	bltu	a1, a6, .LBB4_7
# %bb.6:                                # %b5
	li	a4, 24
.LBB4_7:                                # %b5
	slli	a5, a5, 2
	srl	a3, a3, a5
	sltiu	a5, a3, 4
	xori	a6, a5, 1
	addi	a2, a2, -1
	andi	a2, a2, -4
	add	a2, a4, a2
	slli	a6, a6, 1
	srl	a3, a3, a6
	addi	a5, a5, -1
	andi	a5, a5, -2
	li	a4, 2
	add	a2, a2, a5
	bltu	a3, a4, .LBB4_9
# %bb.8:                                # %b5
	li	a3, -2
	j	.LBB4_10
.LBB4_9:
	neg	a3, a3
.LBB4_10:                               # %b5
	add	a2, a3, a2
	addi	a3, a2, -8
	sll	a1, a1, a3
	lui	a3, 2048
	xor	a1, a1, a3
	slli	a2, a2, 23
	lui	a3, 274432
	sub	a3, a3, a2
	or	a1, a1, a3
.LBB4_11:                               # %b6
	lui	a2, 8
	and	a0, a0, a2
	slli	a0, a0, 16
	or	a0, a1, a0
	ret
.Lfunc_end4:
	.size	__extendhfsf2, .Lfunc_end4-__extendhfsf2
	.cfi_endproc
                                        # -- End function
	.type	__tvm_module_ctx,@object        # @__tvm_module_ctx
	.section	.sbss,"aw",@nobits
	.weak	__tvm_module_ctx
	.p2align	2, 0x0
__tvm_module_ctx:
	.word	0
	.size	__tvm_module_ctx, 4

	.type	__TVMFuncCall,@object           # @__TVMFuncCall
	.weak	__TVMFuncCall
	.p2align	2, 0x0
__TVMFuncCall:
	.word	0
	.size	__TVMFuncCall, 4

	.type	__TVMBackendGetFuncFromEnv,@object # @__TVMBackendGetFuncFromEnv
	.weak	__TVMBackendGetFuncFromEnv
	.p2align	2, 0x0
__TVMBackendGetFuncFromEnv:
	.word	0
	.size	__TVMBackendGetFuncFromEnv, 4

	.type	__TVMAPISetLastError,@object    # @__TVMAPISetLastError
	.weak	__TVMAPISetLastError
	.p2align	2, 0x0
__TVMAPISetLastError:
	.word	0
	.size	__TVMAPISetLastError, 4

	.type	__TVMBackendParallelLaunch,@object # @__TVMBackendParallelLaunch
	.weak	__TVMBackendParallelLaunch
	.p2align	2, 0x0
__TVMBackendParallelLaunch:
	.word	0
	.size	__TVMBackendParallelLaunch, 4

	.type	__TVMBackendParallelBarrier,@object # @__TVMBackendParallelBarrier
	.weak	__TVMBackendParallelBarrier
	.p2align	2, 0x0
__TVMBackendParallelBarrier:
	.word	0
	.size	__TVMBackendParallelBarrier, 4

	.type	.L.str,@object                  # @.str
	.section	.rodata,"a",@progbits
.L.str:
	.asciz	"Assert fail: num_args == 3, before_tensorize: num_args should be 3"
	.size	.L.str, 67

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"Assert fail: A_handle_code == 3 or A_handle_code == 13 or A_handle_code == 7 or A_handle_code == 4, before_tensorize: Expect arg[0] to be pointer"
	.size	.L.str.1, 146

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"Assert fail: B_handle_code == 3 or B_handle_code == 13 or B_handle_code == 7 or B_handle_code == 4, before_tensorize: Expect arg[1] to be pointer"
	.size	.L.str.2, 146

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"Assert fail: C_handle_code == 3 or C_handle_code == 13 or C_handle_code == 7 or C_handle_code == 4, before_tensorize: Expect arg[2] to be pointer"
	.size	.L.str.3, 146

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"Assert fail: 2 == T.tvm_struct_get(A_handle, 0, 4, \"int32\"), before_tensorize.A_handle.ndim is expected to equal 2"
	.size	.L.str.4, 115

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"Assert fail: T.tvm_struct_get(A_handle, 0, 5, \"uint8\") == T.uint8(2) and T.tvm_struct_get(A_handle, 0, 6, \"uint8\") == T.uint8(32) and T.tvm_struct_get(A_handle, 0, 7, \"uint16\") == T.uint16(1), before_tensorize.A_handle.dtype is expected to be float32"
	.size	.L.str.5, 251

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"Assert fail: T.Cast(\"int32\", before_tensorize_A_handle_shape[0]) == 16, Argument before_tensorize.A_handle.shape[0] has an unsatisfied constraint: 16 == T.Cast(\"int32\", before_tensorize_A_handle_shape[0])"
	.size	.L.str.6, 205

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"Assert fail: T.Cast(\"int32\", before_tensorize_A_handle_shape[1]) == 16, Argument before_tensorize.A_handle.shape[1] has an unsatisfied constraint: 16 == T.Cast(\"int32\", before_tensorize_A_handle_shape[1])"
	.size	.L.str.7, 205

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"Assert fail: 1 == T.Cast(\"int32\", before_tensorize_A_handle_strides[1]) and 16 == T.Cast(\"int32\", before_tensorize_A_handle_strides[0]), before_tensorize.A_handle.strides: expected to be compact array"
	.size	.L.str.8, 201

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"Assert fail: T.uint64(0) == T.tvm_struct_get(A_handle, 0, 8, \"uint64\"), Argument before_tensorize.A_handle.byte_offset has an unsatisfied constraint: T.uint64(0) == T.tvm_struct_get(A_handle, 0, 8, \"uint64\")"
	.size	.L.str.9, 208

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"Assert fail: T.tvm_struct_get(A_handle, 0, 10, \"int32\") == 1, Argument before_tensorize.A_handle.device_type has an unsatisfied constraint: 1 == T.tvm_struct_get(A_handle, 0, 10, \"int32\")"
	.size	.L.str.10, 188

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"Assert fail: 2 == T.tvm_struct_get(B_handle, 0, 4, \"int32\"), before_tensorize.B_handle.ndim is expected to equal 2"
	.size	.L.str.11, 115

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"Assert fail: T.tvm_struct_get(B_handle, 0, 5, \"uint8\") == T.uint8(2) and T.tvm_struct_get(B_handle, 0, 6, \"uint8\") == T.uint8(32) and T.tvm_struct_get(B_handle, 0, 7, \"uint16\") == T.uint16(1), before_tensorize.B_handle.dtype is expected to be float32"
	.size	.L.str.12, 251

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"Assert fail: T.Cast(\"int32\", before_tensorize_B_handle_shape[0]) == 16, Argument before_tensorize.B_handle.shape[0] has an unsatisfied constraint: 16 == T.Cast(\"int32\", before_tensorize_B_handle_shape[0])"
	.size	.L.str.13, 205

	.type	.L.str.14,@object               # @.str.14
.L.str.14:
	.asciz	"Assert fail: T.Cast(\"int32\", before_tensorize_B_handle_shape[1]) == 16, Argument before_tensorize.B_handle.shape[1] has an unsatisfied constraint: 16 == T.Cast(\"int32\", before_tensorize_B_handle_shape[1])"
	.size	.L.str.14, 205

	.type	.L.str.15,@object               # @.str.15
.L.str.15:
	.asciz	"Assert fail: 1 == T.Cast(\"int32\", before_tensorize_B_handle_strides[1]) and 16 == T.Cast(\"int32\", before_tensorize_B_handle_strides[0]), before_tensorize.B_handle.strides: expected to be compact array"
	.size	.L.str.15, 201

	.type	.L.str.16,@object               # @.str.16
.L.str.16:
	.asciz	"Assert fail: T.uint64(0) == T.tvm_struct_get(B_handle, 0, 8, \"uint64\"), Argument before_tensorize.B_handle.byte_offset has an unsatisfied constraint: T.uint64(0) == T.tvm_struct_get(B_handle, 0, 8, \"uint64\")"
	.size	.L.str.16, 208

	.type	.L.str.17,@object               # @.str.17
.L.str.17:
	.asciz	"Assert fail: T.tvm_struct_get(B_handle, 0, 10, \"int32\") == 1, Argument before_tensorize.B_handle.device_type has an unsatisfied constraint: 1 == T.tvm_struct_get(B_handle, 0, 10, \"int32\")"
	.size	.L.str.17, 188

	.type	.L.str.18,@object               # @.str.18
.L.str.18:
	.asciz	"Assert fail: dev_id == T.tvm_struct_get(B_handle, 0, 9, \"int32\"), Argument before_tensorize.B_handle.device_id has an unsatisfied constraint: dev_id == T.tvm_struct_get(B_handle, 0, 9, \"int32\")"
	.size	.L.str.18, 194

	.type	.L.str.19,@object               # @.str.19
.L.str.19:
	.asciz	"Assert fail: 2 == T.tvm_struct_get(C_handle, 0, 4, \"int32\"), before_tensorize.C_handle.ndim is expected to equal 2"
	.size	.L.str.19, 115

	.type	.L.str.20,@object               # @.str.20
.L.str.20:
	.asciz	"Assert fail: T.tvm_struct_get(C_handle, 0, 5, \"uint8\") == T.uint8(2) and T.tvm_struct_get(C_handle, 0, 6, \"uint8\") == T.uint8(32) and T.tvm_struct_get(C_handle, 0, 7, \"uint16\") == T.uint16(1), before_tensorize.C_handle.dtype is expected to be float32"
	.size	.L.str.20, 251

	.type	.L.str.21,@object               # @.str.21
.L.str.21:
	.asciz	"Assert fail: T.Cast(\"int32\", before_tensorize_C_handle_shape[0]) == 16, Argument before_tensorize.C_handle.shape[0] has an unsatisfied constraint: 16 == T.Cast(\"int32\", before_tensorize_C_handle_shape[0])"
	.size	.L.str.21, 205

	.type	.L.str.22,@object               # @.str.22
.L.str.22:
	.asciz	"Assert fail: T.Cast(\"int32\", before_tensorize_C_handle_shape[1]) == 16, Argument before_tensorize.C_handle.shape[1] has an unsatisfied constraint: 16 == T.Cast(\"int32\", before_tensorize_C_handle_shape[1])"
	.size	.L.str.22, 205

	.type	.L.str.23,@object               # @.str.23
.L.str.23:
	.asciz	"Assert fail: 1 == T.Cast(\"int32\", before_tensorize_C_handle_strides[1]) and 16 == T.Cast(\"int32\", before_tensorize_C_handle_strides[0]), before_tensorize.C_handle.strides: expected to be compact array"
	.size	.L.str.23, 201

	.type	.L.str.24,@object               # @.str.24
.L.str.24:
	.asciz	"Assert fail: T.uint64(0) == T.tvm_struct_get(C_handle, 0, 8, \"uint64\"), Argument before_tensorize.C_handle.byte_offset has an unsatisfied constraint: T.uint64(0) == T.tvm_struct_get(C_handle, 0, 8, \"uint64\")"
	.size	.L.str.24, 208

	.type	.L.str.25,@object               # @.str.25
.L.str.25:
	.asciz	"Assert fail: T.tvm_struct_get(C_handle, 0, 10, \"int32\") == 1, Argument before_tensorize.C_handle.device_type has an unsatisfied constraint: 1 == T.tvm_struct_get(C_handle, 0, 10, \"int32\")"
	.size	.L.str.25, 188

	.type	.L.str.26,@object               # @.str.26
.L.str.26:
	.asciz	"Assert fail: dev_id == T.tvm_struct_get(C_handle, 0, 9, \"int32\"), Argument before_tensorize.C_handle.device_id has an unsatisfied constraint: dev_id == T.tvm_struct_get(C_handle, 0, 9, \"int32\")"
	.size	.L.str.26, 194

	.type	__tvm_main__,@object            # @__tvm_main__
	.weak	__tvm_main__
__tvm_main__:
	.asciz	"before_tensorize"
	.size	__tvm_main__, 17

	.section	.init_array,"aw",@init_array
	.p2align	2, 0x0
	.word	__tvm_module_startup
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
	.word	.Ltmp1-.Lfunc_begin0
	.word	.Ltmp19-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	142                             # DW_OP_breg30
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	142                             # DW_OP_breg30
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc1:
	.word	.Ltmp2-.Lfunc_begin0
	.word	.Ltmp25-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	141                             # DW_OP_breg29
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	141                             # DW_OP_breg29
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp94-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	141                             # DW_OP_breg29
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc2:
	.word	.Ltmp3-.Lfunc_begin0
	.word	.Ltmp43-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	117                             # DW_OP_breg5
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp81-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	117                             # DW_OP_breg5
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	117                             # DW_OP_breg5
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp112-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	117                             # DW_OP_breg5
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc3:
	.word	.Ltmp4-.Lfunc_begin0
	.word	.Ltmp29-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	140                             # DW_OP_breg28
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	140                             # DW_OP_breg28
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp97-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	140                             # DW_OP_breg28
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc4:
	.word	.Ltmp5-.Lfunc_begin0
	.word	.Ltmp59-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	127                             # DW_OP_breg15
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp84-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	127                             # DW_OP_breg15
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	127                             # DW_OP_breg15
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp133-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	127                             # DW_OP_breg15
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc5:
	.word	.Ltmp6-.Lfunc_begin0
	.word	.Ltmp75-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp80-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp81-.Lfunc_begin0
	.word	.Ltmp83-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp84-.Lfunc_begin0
	.word	.Ltmp86-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp89-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp93-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp94-.Lfunc_begin0
	.word	.Ltmp96-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp97-.Lfunc_begin0
	.word	.Ltmp99-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp100-.Lfunc_begin0
	.word	.Ltmp102-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp103-.Lfunc_begin0
	.word	.Ltmp105-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp106-.Lfunc_begin0
	.word	.Ltmp108-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp109-.Lfunc_begin0
	.word	.Ltmp111-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp112-.Lfunc_begin0
	.word	.Ltmp114-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp115-.Lfunc_begin0
	.word	.Ltmp117-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp118-.Lfunc_begin0
	.word	.Ltmp120-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp121-.Lfunc_begin0
	.word	.Ltmp123-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp124-.Lfunc_begin0
	.word	.Ltmp126-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp127-.Lfunc_begin0
	.word	.Ltmp129-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp130-.Lfunc_begin0
	.word	.Ltmp132-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp133-.Lfunc_begin0
	.word	.Ltmp135-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp136-.Lfunc_begin0
	.word	.Ltmp138-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp139-.Lfunc_begin0
	.word	.Ltmp141-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp142-.Lfunc_begin0
	.word	.Ltmp144-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp145-.Lfunc_begin0
	.word	.Ltmp147-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp148-.Lfunc_begin0
	.word	.Ltmp150-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	.Ltmp151-.Lfunc_begin0
	.word	.Ltmp153-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	123                             # DW_OP_breg11
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc6:
	.word	.Ltmp7-.Lfunc_begin0
	.word	.Ltmp36-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	119                             # DW_OP_breg7
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp81-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	119                             # DW_OP_breg7
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	119                             # DW_OP_breg7
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp103-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	119                             # DW_OP_breg7
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc7:
	.word	.Ltmp8-.Lfunc_begin0
	.word	.Ltmp40-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	118                             # DW_OP_breg6
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp81-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	118                             # DW_OP_breg6
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	118                             # DW_OP_breg6
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp106-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	118                             # DW_OP_breg6
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc8:
	.word	.Ltmp9-.Lfunc_begin0
	.word	.Ltmp77-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	124                             # DW_OP_breg12
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	124                             # DW_OP_breg12
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp156-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	124                             # DW_OP_breg12
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc9:
	.word	.Ltmp10-.Lfunc_begin0
	.word	.Ltmp51-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	129                             # DW_OP_breg17
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp84-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	129                             # DW_OP_breg17
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	129                             # DW_OP_breg17
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp121-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	129                             # DW_OP_breg17
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc10:
	.word	.Ltmp11-.Lfunc_begin0
	.word	.Ltmp55-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	128                             # DW_OP_breg16
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp84-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	128                             # DW_OP_breg16
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	128                             # DW_OP_breg16
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp124-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	128                             # DW_OP_breg16
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc11:
	.word	.Ltmp12-.Lfunc_begin0
	.word	.Ltmp77-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp79-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp81-.Lfunc_begin0
	.word	.Ltmp82-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp84-.Lfunc_begin0
	.word	.Ltmp85-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp87-.Lfunc_begin0
	.word	.Ltmp88-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp92-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp94-.Lfunc_begin0
	.word	.Ltmp95-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp97-.Lfunc_begin0
	.word	.Ltmp98-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp100-.Lfunc_begin0
	.word	.Ltmp101-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp103-.Lfunc_begin0
	.word	.Ltmp104-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp106-.Lfunc_begin0
	.word	.Ltmp107-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp109-.Lfunc_begin0
	.word	.Ltmp110-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp112-.Lfunc_begin0
	.word	.Ltmp113-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp115-.Lfunc_begin0
	.word	.Ltmp116-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp118-.Lfunc_begin0
	.word	.Ltmp119-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp121-.Lfunc_begin0
	.word	.Ltmp122-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp124-.Lfunc_begin0
	.word	.Ltmp125-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp127-.Lfunc_begin0
	.word	.Ltmp128-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp130-.Lfunc_begin0
	.word	.Ltmp131-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp133-.Lfunc_begin0
	.word	.Ltmp134-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp136-.Lfunc_begin0
	.word	.Ltmp137-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp139-.Lfunc_begin0
	.word	.Ltmp140-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp142-.Lfunc_begin0
	.word	.Ltmp143-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp145-.Lfunc_begin0
	.word	.Ltmp146-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp148-.Lfunc_begin0
	.word	.Ltmp149-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp151-.Lfunc_begin0
	.word	.Ltmp152-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	.Ltmp154-.Lfunc_begin0
	.word	.Ltmp155-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	122                             # DW_OP_breg10
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc12:
	.word	.Ltmp13-.Lfunc_begin0
	.word	.Ltmp67-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	126                             # DW_OP_breg14
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	126                             # DW_OP_breg14
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp142-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	126                             # DW_OP_breg14
	.byte	0                               # 0
	.word	0
	.word	0
.Ldebug_loc13:
	.word	.Ltmp14-.Lfunc_begin0
	.word	.Ltmp71-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	125                             # DW_OP_breg13
	.byte	0                               # 0
	.word	.Ltmp78-.Lfunc_begin0
	.word	.Ltmp90-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	125                             # DW_OP_breg13
	.byte	0                               # 0
	.word	.Ltmp91-.Lfunc_begin0
	.word	.Ltmp145-.Lfunc_begin0
	.half	2                               # Loc expr size
	.byte	125                             # DW_OP_breg13
	.byte	0                               # 0
	.word	0
	.word	0
	.section	.debug_abbrev,"",@progbits
	.byte	1                               # Abbreviation Code
	.byte	17                              # DW_TAG_compile_unit
	.byte	1                               # DW_CHILDREN_yes
	.byte	37                              # DW_AT_producer
	.byte	14                              # DW_FORM_strp
	.byte	19                              # DW_AT_language
	.byte	5                               # DW_FORM_data2
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	16                              # DW_AT_stmt_list
	.byte	23                              # DW_FORM_sec_offset
	.byte	27                              # DW_AT_comp_dir
	.byte	14                              # DW_FORM_strp
	.ascii	"\264B"                         # DW_AT_GNU_pubnames
	.byte	25                              # DW_FORM_flag_present
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	2                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	1                               # DW_CHILDREN_yes
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	64                              # DW_AT_frame_base
	.byte	24                              # DW_FORM_exprloc
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	39                              # DW_AT_prototyped
	.byte	25                              # DW_FORM_flag_present
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	3                               # Abbreviation Code
	.byte	5                               # DW_TAG_formal_parameter
	.byte	0                               # DW_CHILDREN_no
	.byte	2                               # DW_AT_location
	.byte	24                              # DW_FORM_exprloc
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	4                               # Abbreviation Code
	.byte	52                              # DW_TAG_variable
	.byte	0                               # DW_CHILDREN_no
	.byte	2                               # DW_AT_location
	.byte	23                              # DW_FORM_sec_offset
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	5                               # Abbreviation Code
	.byte	36                              # DW_TAG_base_type
	.byte	0                               # DW_CHILDREN_no
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	62                              # DW_AT_encoding
	.byte	11                              # DW_FORM_data1
	.byte	11                              # DW_AT_byte_size
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	6                               # Abbreviation Code
	.byte	15                              # DW_TAG_pointer_type
	.byte	0                               # DW_CHILDREN_no
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	7                               # Abbreviation Code
	.byte	15                              # DW_TAG_pointer_type
	.byte	0                               # DW_CHILDREN_no
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	0                               # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.word	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.half	4                               # DWARF version number
	.word	.debug_abbrev                   # Offset Into Abbrev. Section
	.byte	4                               # Address Size (in bytes)
	.byte	1                               # Abbrev [1] 0xb:0x173 DW_TAG_compile_unit
	.word	.Linfo_string0                  # DW_AT_producer
	.half	2                               # DW_AT_language
	.word	.Linfo_string1                  # DW_AT_name
	.word	.Lline_table_start0             # DW_AT_stmt_list
	.word	.Linfo_string2                  # DW_AT_comp_dir
                                        # DW_AT_GNU_pubnames
	.word	.Lfunc_begin0                   # DW_AT_low_pc
	.word	.Lfunc_end1-.Lfunc_begin0       # DW_AT_high_pc
	.byte	2                               # Abbrev [2] 0x26:0x112 DW_TAG_subprogram
	.word	.Lfunc_begin0                   # DW_AT_low_pc
	.word	.Lfunc_end0-.Lfunc_begin0       # DW_AT_high_pc
	.byte	1                               # DW_AT_frame_base
	.byte	82
	.word	.Linfo_string3                  # DW_AT_name
                                        # DW_AT_prototyped
	.word	344                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0x39:0xc DW_TAG_formal_parameter
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	24
	.word	.Linfo_string6                  # DW_AT_name
	.word	351                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0x45:0xc DW_TAG_formal_parameter
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	20
	.word	.Linfo_string7                  # DW_AT_name
	.word	352                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0x51:0xc DW_TAG_formal_parameter
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	16
	.word	.Linfo_string8                  # DW_AT_name
	.word	344                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0x5d:0xc DW_TAG_formal_parameter
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	12
	.word	.Linfo_string9                  # DW_AT_name
	.word	351                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0x69:0xc DW_TAG_formal_parameter
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	8
	.word	.Linfo_string10                 # DW_AT_name
	.word	352                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0x75:0xc DW_TAG_formal_parameter
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	4
	.word	.Linfo_string11                 # DW_AT_name
	.word	351                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0x81:0xd DW_TAG_variable
	.word	.Ldebug_loc0                    # DW_AT_location
	.word	.Linfo_string12                 # DW_AT_name
	.word	344                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0x8e:0xd DW_TAG_variable
	.word	.Ldebug_loc1                    # DW_AT_location
	.word	.Linfo_string13                 # DW_AT_name
	.word	344                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0x9b:0xd DW_TAG_variable
	.word	.Ldebug_loc2                    # DW_AT_location
	.word	.Linfo_string14                 # DW_AT_name
	.word	351                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0xa8:0xd DW_TAG_variable
	.word	.Ldebug_loc3                    # DW_AT_location
	.word	.Linfo_string15                 # DW_AT_name
	.word	344                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0xb5:0xd DW_TAG_variable
	.word	.Ldebug_loc4                    # DW_AT_location
	.word	.Linfo_string16                 # DW_AT_name
	.word	351                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0xc2:0xd DW_TAG_variable
	.word	.Ldebug_loc5                    # DW_AT_location
	.word	.Linfo_string17                 # DW_AT_name
	.word	351                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0xcf:0xd DW_TAG_variable
	.word	.Ldebug_loc6                    # DW_AT_location
	.word	.Linfo_string18                 # DW_AT_name
	.word	357                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0xdc:0xd DW_TAG_variable
	.word	.Ldebug_loc7                    # DW_AT_location
	.word	.Linfo_string20                 # DW_AT_name
	.word	357                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0xe9:0xd DW_TAG_variable
	.word	.Ldebug_loc8                    # DW_AT_location
	.word	.Linfo_string21                 # DW_AT_name
	.word	344                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0xf6:0xd DW_TAG_variable
	.word	.Ldebug_loc9                    # DW_AT_location
	.word	.Linfo_string22                 # DW_AT_name
	.word	357                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0x103:0xd DW_TAG_variable
	.word	.Ldebug_loc10                   # DW_AT_location
	.word	.Linfo_string23                 # DW_AT_name
	.word	357                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0x110:0xd DW_TAG_variable
	.word	.Ldebug_loc11                   # DW_AT_location
	.word	.Linfo_string24                 # DW_AT_name
	.word	369                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0x11d:0xd DW_TAG_variable
	.word	.Ldebug_loc12                   # DW_AT_location
	.word	.Linfo_string26                 # DW_AT_name
	.word	357                             # DW_AT_type
	.byte	4                               # Abbrev [4] 0x12a:0xd DW_TAG_variable
	.word	.Ldebug_loc13                   # DW_AT_location
	.word	.Linfo_string27                 # DW_AT_name
	.word	357                             # DW_AT_type
	.byte	0                               # End Of Children Mark
	.byte	2                               # Abbrev [2] 0x138:0x20 DW_TAG_subprogram
	.word	.Lfunc_begin1                   # DW_AT_low_pc
	.word	.Lfunc_end1-.Lfunc_begin1       # DW_AT_high_pc
	.byte	1                               # DW_AT_frame_base
	.byte	82
	.word	.Linfo_string5                  # DW_AT_name
                                        # DW_AT_prototyped
	.word	344                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0x14b:0xc DW_TAG_formal_parameter
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	12
	.word	.Linfo_string24                 # DW_AT_name
	.word	369                             # DW_AT_type
	.byte	0                               # End Of Children Mark
	.byte	5                               # Abbrev [5] 0x158:0x7 DW_TAG_base_type
	.word	.Linfo_string4                  # DW_AT_name
	.byte	5                               # DW_AT_encoding
	.byte	4                               # DW_AT_byte_size
	.byte	6                               # Abbrev [6] 0x15f:0x1 DW_TAG_pointer_type
	.byte	7                               # Abbrev [7] 0x160:0x5 DW_TAG_pointer_type
	.word	344                             # DW_AT_type
	.byte	7                               # Abbrev [7] 0x165:0x5 DW_TAG_pointer_type
	.word	362                             # DW_AT_type
	.byte	5                               # Abbrev [5] 0x16a:0x7 DW_TAG_base_type
	.word	.Linfo_string19                 # DW_AT_name
	.byte	5                               # DW_AT_encoding
	.byte	8                               # DW_AT_byte_size
	.byte	7                               # Abbrev [7] 0x171:0x5 DW_TAG_pointer_type
	.word	374                             # DW_AT_type
	.byte	5                               # Abbrev [5] 0x176:0x7 DW_TAG_base_type
	.word	.Linfo_string25                 # DW_AT_name
	.byte	4                               # DW_AT_encoding
	.byte	4                               # DW_AT_byte_size
	.byte	0                               # End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"TVM"                           # string offset=0
.Linfo_string1:
	.asciz	"IRModule.CodeGenLLVM"          # string offset=4
.Linfo_string2:
	.asciz	"."                             # string offset=25
.Linfo_string3:
	.asciz	"before_tensorize"              # string offset=27
.Linfo_string4:
	.asciz	"int32"                         # string offset=44
.Linfo_string5:
	.asciz	"before_tensorize_compute_"     # string offset=50
.Linfo_string6:
	.asciz	"args"                          # string offset=76
.Linfo_string7:
	.asciz	"arg_type_ids"                  # string offset=81
.Linfo_string8:
	.asciz	"num_args"                      # string offset=94
.Linfo_string9:
	.asciz	"out_ret_value"                 # string offset=103
.Linfo_string10:
	.asciz	"out_ret_tcode"                 # string offset=117
.Linfo_string11:
	.asciz	"resource_handle"               # string offset=131
.Linfo_string12:
	.asciz	"A_handle.code"                 # string offset=147
.Linfo_string13:
	.asciz	"B_handle.code"                 # string offset=161
.Linfo_string14:
	.asciz	"A_handle"                      # string offset=175
.Linfo_string15:
	.asciz	"C_handle.code"                 # string offset=184
.Linfo_string16:
	.asciz	"B_handle"                      # string offset=198
.Linfo_string17:
	.asciz	"C_handle"                      # string offset=207
.Linfo_string18:
	.asciz	"before_tensorize.A_handle.shape" # string offset=216
.Linfo_string19:
	.asciz	"int64"                         # string offset=248
.Linfo_string20:
	.asciz	"before_tensorize.A_handle.strides" # string offset=254
.Linfo_string21:
	.asciz	"dev_id"                        # string offset=288
.Linfo_string22:
	.asciz	"before_tensorize.B_handle.shape" # string offset=295
.Linfo_string23:
	.asciz	"before_tensorize.B_handle.strides" # string offset=327
.Linfo_string24:
	.asciz	"C"                             # string offset=361
.Linfo_string25:
	.asciz	"float32"                       # string offset=363
.Linfo_string26:
	.asciz	"before_tensorize.C_handle.shape" # string offset=371
.Linfo_string27:
	.asciz	"before_tensorize.C_handle.strides" # string offset=403
	.section	.debug_pubnames,"",@progbits
	.word	.LpubNames_end0-.LpubNames_start0 # Length of Public Names Info
.LpubNames_start0:
	.half	2                               # DWARF Version
	.word	.Lcu_begin0                     # Offset of Compilation Unit Info
	.word	382                             # Compilation Unit Length
	.word	38                              # DIE offset
	.asciz	"before_tensorize"              # External Name
	.word	312                             # DIE offset
	.asciz	"before_tensorize_compute_"     # External Name
	.word	0                               # End Mark
.LpubNames_end0:
	.section	.debug_pubtypes,"",@progbits
	.word	.LpubTypes_end0-.LpubTypes_start0 # Length of Public Types Info
.LpubTypes_start0:
	.half	2                               # DWARF Version
	.word	.Lcu_begin0                     # Offset of Compilation Unit Info
	.word	382                             # Compilation Unit Length
	.word	344                             # DIE offset
	.asciz	"int32"                         # External Name
	.word	362                             # DIE offset
	.asciz	"int64"                         # External Name
	.word	374                             # DIE offset
	.asciz	"float32"                       # External Name
	.word	0                               # End Mark
.LpubTypes_end0:
	.section	".note.GNU-stack","",@progbits
	.section	.debug_line,"",@progbits
.Lline_table_start0:
