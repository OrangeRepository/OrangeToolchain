	.equ	SYS_OPEN, 2
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : open - opens a file
#  INPUT    : %RDI - *filename
#             %RSI - $flags
#             %RDX - $mode
#  OUTPUT   : %RAX - $FD
#  DESTROYS : %RAX, %RCX, %R11
#  CALLS    : syscall
#
	.p2align 4
	.global	Xopen
	.type	Xopen, @function
Xopen:
	movq	$SYS_OPEN, %rax
	syscall
	pushq	%rax
	cmpq	$0, %rax
	jl	.Lopen_err
	popq	%rax
	ret
.Lopen_err:
	popq	%rax
	ret
	.size	Xopen, . - Xopen
