# ====================================================
# ==== Written by ==== OrangeCore ==== Since 2026 ====
# ====================================================
#      Calco, a simple calculator,
#      written fully in Assembly.
#      Don't fuck with this calculator!
# ====================================================
# ========== THERE'S NO DOCUMENTATION BELOW ==========
# ====================================================


	#
	# Syscall numbers
	#
	.equ	SYS_READ, 0
	.equ	SYS_WRITE, 1
	.equ	SYS_EXIT, 60
	#
	# FD
	#
	.equ	STDIN, 0
	.equ	STDOUT, 1


	.extern	sfr_regs_dump
	.extern	sfr_dbpoint


	.global	_start


	.section	.text,"ax",@progbits
.Lerr_zero_division:
	movq	$STDOUT, %rdi
	leaq	.LCerr_zero_division(%rip), %rsi
	movq	$.LCERR_ZERO_DIVISION_LEN, %rdx
	call	.Lwrite
	movq	$-1, %rdi
	jmp	.Lexit

#############################################
#
#  FUNCTION : read - SYS_READ wrapper
#  INPUT    : %RSI - *dest
#             %RDX - $len
#  OUTPUT   : none
#  DESTROYS : %RAX, %RCX, %R11
#  CALLS    : syscall
#
	.type	.Lread, @function
.Lread:
	movq	$SYS_READ, %rax
	movq	$STDIN, %rdi
	syscall
	ret
	.size	.Lread, .-.Lread

#############################################
#
#  FUNCTION : write - SYS_WRITE wrapper
#  INPUT    : %RSI - *src
#             %RDX - $len
#  OUTPUT   : none
#  DESTROYS : %RAX, %RCX, %R11
#  CALLS    : syscall
#
	.type	.Lwrite, @function
.Lwrite:
	movq	$SYS_WRITE, %rax
	syscall
	ret
	.size	.Lwrite, .-.Lwrite

#############################################
#
#  FUNCTION : parse_tokens - parses
#             simple mathematical
#             expression tokens
#  INPUT    : %RDI - *dest
#             %RSI - *src
#  OUTPUT   : %RAX - $sign
#  DESTROYS : %RAX, %RCX, %RDX, %RSI, %RDI
#  CALLS    : none
#
	.type	.Lparse_tokens, @function
.Lparse_tokens:
	cmpb	$'q', (%rsi)
	je	.Lparse_quit
	call	.Lparse_number
	call	.Lparse_sign
	call	.Lparse_number
	ret
.Lparse_number:
	xorq	%rax, %rax
	xorq	%rcx, %rcx
	pushq	%rbx
	movq	$10, %rbx
.Lparse_number_loop:
	cmpb	$' ', (%rsi)
	je	.Lparse_number_save
	cmpb	$0x0A, (%rsi)
	je	.Lparse_number_save
	movb	(%rsi), %cl
	subb	$'0', %cl
	mulq	%rbx
	addq	%rcx, %rax
	incq	%rsi
	jmp	.Lparse_number_loop
.Lparse_number_save:
	movq	%rax, (%rdi)
	addq	$8, %rdi
	incq	%rsi
	popq	%rbx
	ret
.Lparse_sign:
	movb	(%rsi), %cl
	movb	%cl, (%rdi)
	addq	$2, %rsi
	addq	$8, %rdi
	ret
.Lparse_quit:
	movq	$-1, %rax
	ret
	.size	.Lparse_tokens, .-.Lparse_tokens

#############################################
#
#  FUNCTION : calculate - calculates
#             result of two numbers
#  INPUT    : 
#  OUTPUT   : %RAX - $result
#  DESTROYS : 
#  CALLS    : none
#
	.type	.Lcalculate, @function
.Lcalculate:
	cmpb	$'+', 8(%rsi)
	je	.Lcalc_add
	cmpb	$'-', 8(%rsi)
	je	.Lcalc_sub
	cmpb	$'*', 8(%rsi)
	je	.Lcalc_mul
	cmpb	$'/', 8(%rsi)
	je	.Lcalc_div
.Lcalc_add:
	movq	(%rsi), %rax
	movq	16(%rsi), %rcx
	addq	%rcx, %rax
	ret
.Lcalc_sub:
	movq	(%rsi), %rax
	movq	16(%rsi), %rcx
	subq	%rcx, %rax
	ret
.Lcalc_mul:
	movq	(%rsi), %rax
	movq	16(%rsi), %rcx
	mulq	%rcx
	ret
.Lcalc_div:
	movq	(%rsi), %rax
	movq	16(%rsi), %rcx
	testq	%rcx, %rcx
	jz	.Lcalc_div_zero
	xorq	%rdx, %rdx
	divq	%rcx
	ret
.Lcalc_div_zero:
	movq	$-1, %rax
	ret
	.size	.Lcalculate, .-.Lcalculate

#############################################
#
#  FUNCTION : itoa - int to ASCII
#  INPUT    : %RAX - $src
#             %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RAX, %RCX, %RDX,
#             %RSI, %RDI
#  CALLS    : none
#
	.type	.Litoa, @function
.Litoa:
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
	ret
	.size	.Litoa, . - .Litoa

#############################################
#
#  FUNCTION : strlen - get string length
#  INPUT    : %RDI - *null-terminated string
#  OUTPUT   : %RAX - $string len (exc. null)
#  DESTROYS : %RAX, %RCX,
#             %RDX, %RDI
#  CALLS    : none
#
	.type	.Lstrlen, @function
.Lstrlen:
	movq	%rdi, %rdx		# saving the OG
	movl	$0xFFFFFFFF, %ecx	# garbaging %RCX for scasb
	xorq	%rax, %rax		# checking for 0
	repne	scasb
 	decq	%rdi			# skipping 0
	subq	%rdx, %rdi		# calculating len w/o 0
	movq	%rdi, %rax		# returning in %RAX
	ret
	.size	.Lstrlen, .-.Lstrlen

.Lins_yellow_col:
	movb	$0x1B, (%rdi)
	incq	%rdi
	#
	# "[33m"
	#
	movl	$0x6D33335B, (%rdi)
	addq	$4, %rdi
	ret

.Lins_word_result:
	#
	# "Result: "
	#
	movabsq	$0x203A746C75736552, %rcx
	movq	%rcx, (%rdi)
	addq	$8, %rdi
	ret

.Lins_purple_col:
	movb	$0x1B, (%rdi)
	incq	%rdi
	#
	# "[35m"
	#
	movl	$0x6D35335B, (%rdi)
	addq	$4, %rdi
	ret

.Lins_col_res:
	#
	# ESC + "[0m"
	#
	movl	$0x6D305B1B, (%rdi)
	addq	$4, %rdi
	#
	movb	$0x0A, (%rdi)
	incq	%rdi
	ret

.Lquit:
	xorq	%rdi, %rdi
	jmp	.Lexit

#############################################
#
#  FUNCTION : exit
#  INPUT    : none
#  OUTPUT   : none
#  DESTROYS : none
#  CALLS    : syscall
#
	.type	.Lexit, @function
.Lexit:
	movq	$SYS_EXIT, %rax
	syscall
	.size	.Lexit, .-.Lexit

	.type	_start, @function
_start:
	movq	$STDOUT, %rdi
	leaq	.LCcalco_header(%rip), %rsi
	movq	$.LCCALCO_HEADER_LEN, %rdx
	call	.Lwrite
	##
.Lrepeat:
	movq	$STDOUT, %rdi
	leaq	.LCprompt(%rip), %rsi
	movq	$.LCPROMPT_LEN, %rdx
	call	.Lwrite
	##
	leaq	.Lbuf_in(%rip), %rsi
	movq	$.LBUF_IN_SIZE, %rdx
	call	.Lread
	##
	leaq	.Lbuf_tokens(%rip), %rdi
	leaq	.Lbuf_in(%rip), %rsi
	call	.Lparse_tokens
	cmpq	$0, %rax
	jl	.Lquit
	##
	leaq	.Lbuf_out(%rip), %rdi
	leaq	.Lbuf_tokens(%rip), %rsi
	call	.Lcalculate
	cmpq	$-1, %rax
	je	.Lerr_zero_division
	##
	leaq	.Lbuf_out(%rip), %rdi
	call	.Lins_yellow_col
	##
	call	.Lins_word_result
	##
	call	.Lins_purple_col
	##
	call	.Litoa
	##
	call	.Lins_col_res
	##
	leaq	.Lbuf_out(%rip), %rdi
	call	.Lstrlen
	##
	movq	$STDOUT, %rdi
	leaq	.Lbuf_out(%rip), %rsi
	movq	%rax, %rdx
	call	.Lwrite
	##
	jmp	.Lrepeat
	.size	_start, .-_start


	.section	.rodata.str1.1,"aMS",@progbits,1
.LCcalco_header:
	.ascii	"\033[33mCalco by OrangeCore.\n"
	.ascii	"\033[34mType 'q' if you want to quit.\033[0m\n"
	.equ	.LCCALCO_HEADER_LEN, . - .LCcalco_header

.LCprompt:
	.asciz	"\033[33mExpression:\033[35m "
	.equ	.LCPROMPT_LEN, .-.LCprompt

.LCerr_zero_division:
	.ascii	"\033[31merror:\033[33m division by zero\033[0m\n"
	.equ	.LCERR_ZERO_DIVISION_LEN, . - .LCerr_zero_division


	.section	.bss,"aw",@nobits
	.p2align 4
.Lbuf_in:
	.zero	64
	.equ	.LBUF_IN_SIZE, 32

.Lbuf_tokens:
	.zero	64

.Lbuf_out:
	.zero	64
