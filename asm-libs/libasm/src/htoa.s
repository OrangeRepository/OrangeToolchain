	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : htoa - hex to ASCII
#  INPUT    : %RDI - *dest
#             %RSI - $src
#             %RDX - $hex-digits-number
#  OUTPUT   : %RAX - *dest-original
#             ON-ERROR: %RAX - $return-code
#  DESTROYS : %RAX, %RDX, %RCX,
#             %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xhtoa
	.type	Xhtoa, @function
Xhtoa:
	testq	%rdx, %rdx
	jz	.Lhtoa_zero_err
	cmpl	$16, %edx
	ja	.Lhtoa_len_err
	pushq	%rdi
	pushq	%rbx
	movl	%edx, %ecx
	movq	%rcx, %rbx
	movq	%rsi, %rax
	xorl	%edx, %edx
	movw	$0x7830, (%rdi)
	addq	$2, %rdi
.Lhtoa_push_loop:
	movb	%al, %dl
	andb	$0x0F, %dl
	leaq	.LChex_lookup_table(%rip), %rsi
	leaq	(%rsi, %rdx, 1), %rsi
	movb	(%rsi), %dl
	pushq	%rdx
	shrq	$4, %rax
	decl	%ecx
	jnz	.Lhtoa_push_loop
	movl	%ebx, %ecx
.Lhtoa_pop_loop:
	popq	%rax
	movb	%al, (%rdi)
	incq	%rdi
	decl	%ecx
	jnz	.Lhtoa_pop_loop
	popq	%rbx
	popq	%rax
	ret
.Lhtoa_zero_err:
	movq	$-2, %rax
	ret
.Lhtoa_len_err:
	movq	$-1, %rax
	ret
	.size	Xhtoa, . - Xhtoa


	.section	.rodata.str1.1,"aMS",@progbits,1
	.type	.LChex_lookup_table, @object
.LChex_lookup_table:
	.ascii	"0123456789ABCDEF"
	.size	.LChex_lookup_table, . - .LChex_lookup_table
