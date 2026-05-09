	.equ	SYS_ACCEPT, 43
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : accept - 
#  INPUT    : 
#  OUTPUT   : 
#  DESTROYS : 
#  CALLS    : syscall
#
	.p2align 4
	.global	Xaccept
	.type	Xaccept, @function
Xaccept:
	movq	$SYS_ACCEPT, %rax
	syscall
	ret
	.size	Xaccept, . - Xaccept
