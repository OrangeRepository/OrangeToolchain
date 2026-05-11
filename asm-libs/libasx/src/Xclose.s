	.section	.text,"ax",@progbits
	.equ	SYS_CLOSE, 3
#############################################
#
#  FUNCTION : Xclose - closes a file
#  INPUT    : %RDI - $FD
#  OUTPUT   : none
#  DESTROYS : %RAX, %RCX, %R11
#  CALLS    : syscall
#
	.p2align 4
	.global	Xclose
	.type	Xclose, @function
Xclose:
	movl	$SYS_CLOSE, %eax
	syscall
	ret
	.size	Xclose, . - Xclose
