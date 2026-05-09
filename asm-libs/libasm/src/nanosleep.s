	.section	.text,"ax",@progbits
	.equ	SYS_NANOSLEEP, 35
#############################################
#
#  FUNCTION : nanosleep - high-precision
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
	movq	$SYS_NANOSLEEP, %rax
	syscall
	ret
	.size	Xnanosleep, . - Xnanosleep
