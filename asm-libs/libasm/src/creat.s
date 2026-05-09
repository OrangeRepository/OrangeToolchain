	.equ	SYS_CREAT, 85
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : creat - creates a file
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
	movq	$SYS_CREAT, %rax
	syscall
	ret
	.size	Xcreat, . - Xcreat
