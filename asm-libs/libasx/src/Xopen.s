	.equ	SYS_OPEN, 2
	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : Xopen - opens a file
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
	movl	$SYS_OPEN, %eax
	syscall
	#
	pushq	%rax
	cmpl	$0, %eax
	jl	.Lopen_err
	#
	popq	%rax
	ret
.Lopen_err:
	popq	%rax
	ret
	.size	Xopen, . - Xopen
