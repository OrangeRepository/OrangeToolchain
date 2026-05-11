	.equ	DIVISOR, 10


	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : Xitoa_s - signed int
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
	.type	Xitoa_s, @function
	.global	Xitoa_s
Xitoa_s:
	testq	%rdi, %rdi
	jz	.Linvalid_ptr
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
	js	.Lsigned
	jnz	.Lpush_loop_skip_zero_test
	#
	# Handling zero
	#
	movb	$'0', %dl
	incl	%ecx
	pushq	%rdx
	jmp	.Lpop_loop
.Lsigned:
	movb	$'-', (%rdi)
	incq	%rdi
	negq	%rax
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
	# Null-terminating *dest
	#
	movb	$0, (%rdi)
	incq	%rdi
	#
	# Returning *dest-original
	#
	popq	%rax
	ret
.Linvalid_ptr:
	movq	$-1, %rax
	ret
	.size	Xitoa_s, . - Xitoa_s
