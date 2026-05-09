	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : atoi - ASCII to int
#  INPUT    : %RDI - *src
#  OUTPUT   : %RAX - $result
#  DESTROYS : %RAX, %RCX, %RDX,
#             %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
	.type	Xatoi, @function
	.global	Xatoi
Xatoi:
	xorq	%rax, %rax
	xorq	%rcx, %rcx
	xorq	%r10, %r10
	xorq	%r9, %r9
	movq	$10, %r8
	#
	cmpb	$'-', (%rdi)
	jne	.Latoi_loop
	movq	$1, %r10
	incq	%rdi
.Latoi_loop:
	cmpb	$'0', (%rdi)
	jb	.Latoi_loop_done
	cmpb	$'9', (%rdi)
	ja	.Latoi_loop_done
	#
	movb	(%rdi), %r9b
	subb	$'0', %r9b
	xorq	%rdx, %rdx
	mulq	%r8
	addq	%r9, %rax
	#
	incq	%rdi
	jmp	.Latoi_loop
.Latoi_loop_done:
	cmpq	$1, %r10
	jne	.Latoi_done
	negq	%rax
	ret
.Latoi_done:
	ret
	.size	Xatoi, . - Xatoi
