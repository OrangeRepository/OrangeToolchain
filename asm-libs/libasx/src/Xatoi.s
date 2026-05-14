	.equ	MULTIPLIER, 10


	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : Xatoi - ASCII to int
#  INPUT    : %RDI - *src
#  OUTPUT   : %RAX - $result
#             on-error:
#             %RAX - $return-code
#  DESTROYS : %RAX, %RCX, %RDX,
#             %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
	.type	Xatoi, @function
	.global	Xatoi
Xatoi:
	testq	%rdi, %rdi
	jz	.Lerr_invalid_ptr
	#
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	movl	$MULTIPLIER, %ecx
	#
	cmpb	$'-', (%rdi)
	jne	.Lloop
	#
	movl	$1, %r9d
	incq	%rdi
.Lloop:
	cmpb	$'0', (%rdi)
	jb	.Lloop_done
	cmpb	$'9', (%rdi)
	ja	.Lloop_done
	#
	movb	(%rdi), %r8b
	subb	$'0', %r8b
	#
	mulq	%rcx
	jc	.Lerr_overflow
	#
	addq	%r8, %rax
	jc	.Lerr_overflow
	#
	incq	%rdi
	jmp	.Lloop
.Lloop_done:
	testl	%r9d, %r9d
	jz	.Ldone
	#
	negq	%rax
.Ldone:
	ret
.Lerr_invalid_ptr:
	movq	$-1, %rax
	ret
.Lerr_overflow:
	movq	$-2, %rax
	ret
	.size	Xatoi, . - Xatoi
