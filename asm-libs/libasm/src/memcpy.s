	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : memcpy - copies one
#             memory address into
#             another memory address
#  INPUT    : %RDI - *dest
#             %RSI - *src
#             %RDX - $len
#  OUTPUT   : %RAX - *dest-original
#  DESTROYS : %RAX, %RCX,
#             %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xmemcpy
	.type	Xmemcpy, @function
Xmemcpy:
	movq	%rdi, %rax
	movq	%rdx, %rcx
	rep movsb
	ret
	.size	Xmemcpy, . - Xmemcpy
