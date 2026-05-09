	.equ	SYS_WRITE, 1
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : write - writes into $FD
#  INPUT    : %RDI - $FD
#             %RSI - *src
#             %RDX - $len
#  OUTPUT   : $FD - data
#  DESTROYS : %RAX, %RCX, %R11
#  CALLS    : syscall
#
	.p2align 4
	.global	Xwrite
	.type	Xwrite, @function
Xwrite:
	movq	$SYS_WRITE, %rax
	syscall
	ret
	.size	Xwrite, . - Xwrite
