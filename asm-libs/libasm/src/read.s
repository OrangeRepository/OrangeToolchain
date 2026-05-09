	.equ	SYS_READ, 0
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : read - reads into *dest
#  INPUT    : %RDI - $FD
#             %RSI - *dest
#             %RDX - $len
#  OUTPUT   : *dest - data
#  DESTROYS : %RAX, %RCX, %R11
#  CALLS    : syscall
#
	.p2align 4
	.global	Xread
	.type	Xread, @function
Xread:
	movq	$SYS_READ, %rax
	syscall
	ret
	.size	Xread, . - Xread
