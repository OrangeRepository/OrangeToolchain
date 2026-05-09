	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : itoa - int to ASCII
#  INPUT    : %RDI - *dest
#             %RSI - $src
#  OUTPUT   : %RAX - *dest-original
#  DESTROYS : %RAX, %RCX, %RDX,
#             %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
	.type	Xitoa, @function
	.global	Xitoa
Xitoa:
	pushq	%rdi
	movq	%rsi, %rax
	xorq	%rcx, %rcx
	movq	$10, %rsi
	testq	%rax, %rax
	js	.Litoa_signed
	jnz	.Litoa_loop_skip_test
	movb	$'0', %dl
	incq	%rcx
	pushq	%rdx
	jmp	.Litoa_pop_loop
.Litoa_signed:
	movb	$'-', (%rdi)
	incq	%rdi
	negq	%rax
.Litoa_push_loop:
	testq	%rax, %rax
	jz	.Litoa_pop_loop
.Litoa_loop_skip_test:
	xorq	%rdx, %rdx
	divq	%rsi
	incq	%rcx
	addb	$'0', %dl
	pushq	%rdx
	jmp	.Litoa_push_loop
.Litoa_pop_loop:
	popq	%rdx
	movb	%dl, (%rdi)
	incq	%rdi
	decq	%rcx
	jnz	.Litoa_pop_loop
	popq	%rax
	ret
	.size	Xitoa, . - Xitoa
