	.section	.text,"ax",@progbits
	.equ	SYS_CLOSE, 3
#############################################
#
#  FUNCTION : close - closes a file
#  INPUT    : %RDI - $FD
#  OUTPUT   : none
#  DESTROYS : %RAX, %RCX, %R11
#  CALLS    : syscall
#
	.p2align 4
	.global	Xclose
	.type	Xclose, @function
Xclose:
	movq	$SYS_CLOSE, %rax
	syscall
	ret
	.size	Xclose, . - Xclose
