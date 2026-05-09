	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : memset - memory set.
#             fills specified memory
#             region with a byte value
#  INPUT    : %RDI - *dest
#             %RSI - $byte
#             %RDX - $len
#  OUTPUT   : %RAX - *dest-original
#  DESTROYS : %RAX, %RCX, %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xmemset
	.type	Xmemset, @function
Xmemset:
	pushq	%rdi
	movb	%sil, %al
	movq	%rdx, %rcx
	rep stosb
	popq	%rax
	ret
	.size	Xmemset, . - Xmemset
