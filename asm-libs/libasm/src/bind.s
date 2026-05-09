	.equ	SYS_BIND, 49
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : bind - 
#  INPUT    : 
#  OUTPUT   : 
#  DESTROYS : 
#  CALLS    : syscall
#
	.p2align 4
	.global	Xbind
	.type	Xbind, @function
Xbind:
	movq	$SYS_BIND, %rax
	syscall
	ret
	.size	Xbind, . - Xbind
