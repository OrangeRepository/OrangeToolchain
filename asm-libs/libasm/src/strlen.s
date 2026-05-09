	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : strlen - get string length
#  INPUT    : %RDI - *null-terminated-string
#  OUTPUT   : %RAX - $str-len-no-null
#  DESTROYS : %RAX, %RCX,
#             %RDX, %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xstrlen
	.type	Xstrlen, @function
Xstrlen:
	movq	%rdi, %rdx
	movq	$-1, %rcx
	xorq	%rax, %rax
	repne scasb
	decq	%rdi
	subq	%rdx, %rdi
	movq	%rdi, %rax
	ret
	.size	Xstrlen, . - Xstrlen
