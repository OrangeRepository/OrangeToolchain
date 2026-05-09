	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : pow - calculates the value
#             of base raised to exponent
#  INPUT    : %RDI - $base
#             %RSI - $exponent
#  OUTPUT   : %RAX - $result
#  DESTROYS : %RAX, %RCX,
#             %RDX, %R8
#  CALLS    : none
#
	.p2align 4
	.global	Xpow
	.type	Xpow, @function
Xpow:
	testq	%rsi, %rsi
	jz	.Lpow_zero
	movq	%rdi, %rax
	cmpq	$1, %rsi
	je	.Lpow_done
	movq	%rdi, %r8
	movq	%rsi, %rcx
	decq	%rcx
.Lpow_loop:
	mulq	%r8
	decq	%rcx
	jnz	.Lpow_loop
	ret
.Lpow_done:
	ret
.Lpow_zero:
	movq	$1, %rax
	ret
	.size	Xpow, . - Xpow
