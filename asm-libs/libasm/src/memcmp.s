	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : memcmp - compares two
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
	xorq	%rax, %rax
	ret
.Lmemcmp_greater:
	movq	$1, %rax
	ret
	.size	Xmemcmp, . - Xmemcmp
