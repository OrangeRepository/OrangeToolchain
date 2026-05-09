	.equ	SYS_SOCKET, 41
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : socket - 
#  INPUT    : 
#  OUTPUT   : 
#  DESTROYS : 
#  CALLS    : syscall
#
	.p2align 4
	.global	Xsocket
	.type	Xsocket, @function
Xsocket:
	movq	$SYS_SOCKET, %rax
	syscall
	ret
	.size	Xsocket, . - Xsocket
