	.equ	SYS_LISTEN, 50
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : listen - 
#  INPUT    : 
#  OUTPUT   : 
#  DESTROYS : 
#  CALLS    : syscall
#
	.p2align 4
	.global	Xlisten
	.type	Xlisten, @function
Xlisten:
	movq	$SYS_LISTEN, %rax
	syscall
	ret
	.size	Xlisten, . - Xlisten
