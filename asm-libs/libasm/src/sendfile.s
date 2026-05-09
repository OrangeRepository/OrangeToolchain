	.equ	SYS_SENDFILE, 40
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : sendfile - sends a file
#             without copying it
#  INPUT    : 
#  OUTPUT   : 
#  DESTROYS : 
#  CALLS    : syscall
#
	.p2align 4
	.global	Xsendfile
	.type	Xsendfile, @function
Xsendfile:
	movq	$SYS_SENDFILE, %rax
	syscall
	ret
	.size	Xsendfile, . - Xsendfile
