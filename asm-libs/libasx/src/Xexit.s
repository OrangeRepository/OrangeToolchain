	.section	.text,"ax",@progbits
	.equ	SYS_EXIT, 60
#############################################
#
#  FUNCTION : Xexit - exits the program
#  INPUT    : %RDI - $exit-code
#  OUTPUT   : none
#  DESTROYS : none
#  CALLS    : syscall
#
	.p2align 4
	.global	Xexit
	.type	Xexit, @function
Xexit:
	movl	$SYS_EXIT, %eax
	syscall
	.size	Xexit, . - Xexit
