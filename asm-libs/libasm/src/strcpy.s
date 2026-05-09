	.section	.text,"ax",@progbits
#############################################
# 
#  FUNCTION : strcpy - string copy
#  INPUT    : %RDI - *dest
#             %RSI - *src
#  OUTPUT   : %RAX - *dest (original)
#  DESTROYS : %RAX, %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xstrcpy
	.type	Xstrcpy, @function
Xstrcpy:
	pushq	%rdi
	xorq	%rax, %rax
.Lstrcpy_loop:
	movb	(%rsi), %al
	cmpb	$0, %al
	je	.Lstrcpy_done
	movb	%al, (%rdi)
	incq	%rsi
	incq	%rdi
	jmp	.Lstrcpy_loop
.Lstrcpy_done:
	popq	%rax
	ret
	.size	Xstrcpy, . - Xstrcpy
