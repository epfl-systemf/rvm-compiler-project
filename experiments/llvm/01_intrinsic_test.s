	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_xtheadmatrix0p1"
	.file	"01_intrinsic_test.ll"
	.globl	test_thead                      # -- Begin function test_thead
	.p2align	2
	.type	test_thead,@function
test_thead:                             # @test_thead
	.cfi_startproc
# %bb.0:
	li	a1, 16
	mld.w	m0, (a0), a1
	fmmacc.s	m0, m0, m0
	mst.w	m0, (a0), a1
	ret
.Lfunc_end0:
	.size	test_thead, .Lfunc_end0-test_thead
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
