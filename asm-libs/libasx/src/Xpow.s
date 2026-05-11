	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : Xpow - calculates the value
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
	testl	%esi, %esi
	jz	.Lpow_zero
	#
	movl	%edi, %eax
	#
	cmpl	$1, %esi
	je	.Lpow_done
	#
	movl	%edi, %r8d
	movl	%esi, %ecx
	#
	# Without this decrement,
	# the loop would perform
	# one extra iteration
	#
	decl	%ecx
.Lpow_loop:
	mulq	%r8
	#
	jc	.Lpow_overflow
	#
	decl	%ecx
	jnz	.Lpow_loop
	ret
.Lpow_zero:
	movl	$1, %eax
	ret
.Lpow_done:
	ret
.Lpow_overflow:
	movq	$-1, %rax
	ret
	.size	Xpow, . - Xpow
