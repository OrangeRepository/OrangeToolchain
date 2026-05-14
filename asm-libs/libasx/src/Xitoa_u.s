	.equ	DIVISOR, 10


	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : Xitoa_u - unsigned int
#             to ASCII function
#  INPUT    : %RDI - *dest
#             %RSI - $src
#  OUTPUT   : %RAX - *dest-original
#             on-error:
#             %RAX - $return-code
#  DESTROYS : %RAX, %RCX, %RDX,
#             %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
	.type	Xitoa_u, @function
	.global	Xitoa_u
Xitoa_u:
	testq	%rdi, %rdi
	jz	.Lerr_invalid_ptr
	#
	# For returning *dest-original
	#
	pushq	%rdi
	#
	movq	%rsi, %rax
	movl	$DIVISOR, %esi
	xorl	%ecx, %ecx
	#
	testq	%rax, %rax
	jnz	.Lpush_loop_skip_zero_test
	#
	# Handling zero
	#
	movb	$'0', %dl
	incl	%ecx
	pushq	%rdx
	jmp	.Lpop_loop
.Lpush_loop:
	testq	%rax, %rax
	jz	.Lpop_loop
.Lpush_loop_skip_zero_test:
	xorl	%edx, %edx
	divq	%rsi
	#
	# Preparing digit for pop_loop
	#
	incl	%ecx
	addb	$'0', %dl
	pushq	%rdx
	jmp	.Lpush_loop
.Lpop_loop:
	popq	%rdx
	movb	%dl, (%rdi)
	incq	%rdi
	#
	decl	%ecx
	jnz	.Lpop_loop
	#
	# Returning *dest-original
	#
	popq	%rax
	ret
.Lerr_invalid_ptr:
	movq	$-1, %rax
	ret
	.size	Xitoa_u, . - Xitoa_u
