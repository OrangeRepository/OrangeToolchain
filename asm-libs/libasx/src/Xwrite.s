	.equ	SYS_WRITE, 1
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : Xwrite - writes into $FD
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
	movl	$SYS_WRITE, %eax
	syscall
	ret
	.size	Xwrite, . - Xwrite
