	.section	.text,"ax",@progbits
	.equ	SYS_NANOSLEEP, 35
#############################################
#
#  FUNCTION : Xnanosleep - high-precision
#             sleep function
#  INPUT    : %RDI - timespec *req
#             %RSI - timespec *rem
#  OUTPUT   : %RAX - return code
#  DESTROYS : %RAX, %RCX, %R11
#  CALLS    : syscall
#
	.p2align 4
	.global	Xnanosleep
	.type	Xnanosleep, @function
Xnanosleep:
	movl	$SYS_NANOSLEEP, %eax
	syscall
	ret
	.size	Xnanosleep, . - Xnanosleep
