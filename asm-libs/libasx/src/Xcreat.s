	.equ	SYS_CREAT, 85
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : Xcreat - creates a file
#  INPUT    : %RDI - *filename
#             %RSI - $mode
#  OUTPUT   : none
#  DESTROYS : %RAX, %RCX, %R11
#  CALLS    : syscall
#
	.p2align 4
	.global	Xcreat
	.type	Xcreat, @function
Xcreat:
	movl	$SYS_CREAT, %eax
	syscall
	ret
	.size	Xcreat, . - Xcreat
