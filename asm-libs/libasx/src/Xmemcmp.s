	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : Xmemcmp - compares two
#             memory addresses, and
#             returns -1 if they're
#             not equal
#  INPUT    : %RDI - *dest
#             %RSI - *src
#             %RDX - $len
#  OUTPUT   : %RAX - $return-code
#  DESTROYS : %RAX, %RCX
#             %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xmemcmp
	.type	Xmemcmp, @function
Xmemcmp:
	movq	%rdx, %rcx
	repe cmpsb
	je	.Lmemcmp_equal
	ja	.Lmemcmp_greater
	movq	$-1, %rax
	ret
.Lmemcmp_equal:
	xorl	%eax, %eax
	ret
.Lmemcmp_greater:
	movl	$1, %eax
	ret
	.size	Xmemcmp, . - Xmemcmp
