# ====================================================
# ==== Written by ==== OrangeCore ==== Since 2026 ====
# ====================================================
#       Aview - ASCII-Viewer.
#       Or, in other words,
#       Hex-To-ASCII converter.
# ====================================================
# ========== THERE'S NO DOCUMENTATION BELOW ==========
# ====================================================


	.equ	BUF_IN_SIZE, 1024
	.equ	BUF_OUT_SIZE, 1024


	.macro	SYSCALL_PUSH
		pushq	%rax
		pushq	%rdi
		pushq	%rsi
		pushq	%rdx
		pushq	%rcx
		pushq	%r11
	.endm
	.macro	SYSCALL_POP
		popq	%r11
		popq	%rcx
		popq	%rdx
		popq	%rsi
		popq	%rdi
		popq	%rax
	.endm
	.macro	INS_RED_COL
		#
		# ESC + "[31m"
		# (format: little-endian)
		#
		movl	$0x31335B1B, (%rdi)
		addq	$4, %rdi
		movb	$0x6D, %dl
		movb	%dl, (%rdi)
		incq	%rdi
	.endm
	.macro	INS_YELLOW_COL
		#
		# ESC + "[33m"
		# (format: little-endian)
		#
		movl	$0x33335B1B, (%rdi)
		addq	$4, %rdi
		movb	$0x6D, %dl
		movb	%dl, (%rdi)
		incq	%rdi
	.endm
	.macro	INS_COL_RES
		#
		# ESC + "[0m"
		# (format: little-endian)
		#
		movl	$0x6D305B1B, (%rdi)
		addq	$4, %rdi
	.endm
	.macro	INS_NEWLINE
		movb	$0x0A, (%rdi)
		incq	%rdi
	.endm
	.macro	INS_HEX_PFX
		movw	$0x7830, (%rdi)
		addq	$2, %rdi
	.endm
	.macro	INS_OUT_PFX
		#
		# "H"
		# (format: little-endian)
		#
		movb	$0x48, (%rdi)
		incq	%rdi	
		#
		# "EX: "
		#
		movl	$0x203A5845, (%rdi)
		addq	$4, %rdi
	.endm
	.macro	WRITE_PROMPT
		SYSCALL_PUSH
		movl	$1, %eax
		movl	$1, %edi
		leaq	.LCprompt(%rip), %rsi
		movl	$.LCPROMPT_LEN, %edx
		syscall
		SYSCALL_POP
	.endm
	.macro	READ_BUF_IN
		pushq	%rdi
		pushq	%rsi
		pushq	%rdx
		pushq	%rcx
		pushq	%r11
		xorl	%eax, %eax
		xorl	%edi, %edi
		leaq	.Lbuf_in(%rip), %rsi
		movl	$BUF_IN_SIZE-1, %edx	# byte for 0x0A
		syscall
		popq	%r11
		popq	%rcx
		popq	%rdx
		popq	%rsi
		popq	%rdi
		#
		# The counted bytes are
		# already inside of %RAX,
		# we just multiply it by 2
		# for the further conversion.
		#
		subl	$1, %eax	# removing newline
		pushq	%rax
		movl	$2, %ebx
		mull	%ebx
		movl	%eax, %ebx
	.endm
	.macro	ASCII_TO_HEX
			INS_YELLOW_COL
			INS_OUT_PFX
			INS_NEWLINE
			INS_RED_COL
			INS_HEX_PFX
			xorq	%rdx, %rdx
			movl	%ebx, %ecx
			movq	(%rsi), %rax
			cmpq	$0x0A, %rax	# zero input checking
			jnz	.Latoh_loop
			incl	%ecx
			movb	$'0', %dl
			pushq	%rdx
			jmp	.Latoh_loop2
		.Latoh:
			movq	(%rsi), %rax
		.Latoh_loop:
			cmpl	$16, %r8d	# for the shift each 8 bytes
			jz	.Latoh_gate
			movb	%al, %dl
			andb	$0x0F, %dl
			leaq	.LChex_table(%rip), %r9
			leaq	(%r9, %rdx, 1), %r9
			movb	(%r9), %dl
			pushq	%rdx
			shrq	$4, %rax
			incl	%r8d
			decl	%ecx
			jnz	.Latoh_loop
			xorl	%r8d, %r8d
			movl	%ebx, %ecx
		.Latoh_loop2:
			cmpl	$16, %r8d	# for the space each 8 bytes
			jz	.Latoh_gate2
			popq	%rdx
 			movb	%dl, (%rdi)
			incq	%rdi
			incl	%r8d
			decl	%ecx
			jnz	.Latoh_loop2
			jmp	.Latoh_pass
		.Latoh_gate:
			xorl	%r8d, %r8d
			addq	$8, %rsi
			jmp	.Latoh
		.Latoh_gate2:
			xorl	%r8d, %r8d
			INS_NEWLINE
			INS_HEX_PFX
			jmp	.Latoh_loop2
		.Latoh_pass:
			INS_NEWLINE
	.endm
	.macro	INS_TOTAL_LEN
			INS_YELLOW_COL
			#
			# "AS"
			# (format: little-endian)
			#
			movw	$0x5341, (%rdi)
			addq	$2, %rdi
			#
			# "CII "
			#
			movl	$0x20494943, (%rdi)
			addq	$4, %rdi
			#
			# "Length: "
			#
			movabsq	$0x203A6874676E654C, %rdx
			movq	%rdx, (%rdi)
			addq	$8, %rdi
			movl	$10, %ebx	# for division
			popq	%rax
			cmpq	$0, %rax
			jnz	.Litoa_loop
			movb	$'0', %dl
			incl	%ecx
			pushq	%rdx
			jmp	.Litoa_loop2
		.Litoa_loop:
			cmpq	$0, %rax
			jz	.Litoa_loop2
			xorl	%edx, %edx
			divl	%ebx
			addb	$'0', %dl
			incl	%ecx
			pushq	%rdx
			jmp	.Litoa_loop
		.Litoa_loop2:
			popq	%rdx
			movb	%dl, (%rdi)
			incq	%rdi
			decl	%ecx
			jnz	.Litoa_loop2
			movw	$0x6220, (%rdi)
			addq	$2, %rdi
			movl	$0x73657479, (%rdi)
			addq	$4, %rdi
			INS_NEWLINE
	.endm
	.macro	CALC_OUT_LEN
		movq	%rdi, %rdx
		leaq	.Lbuf_out(%rip), %rax
		subq	%rax, %rdx
	.endm
 	.macro	WRITE_BUF_OUT
		movq	$1, %rax
		movq	$1, %rdi
		leaq	.Lbuf_out(%rip), %rsi
		syscall		# %RDX already calculated
	.endm
	.macro	EXIT
		movl	$60, %eax
		xorl	%edi, %edi
		syscall
	.endm


	.extern	sfr_regs_dump
	.extern sfr_dbpoint


	.global	_start

 
	.section	.text,"ax",@progbits
	.type	_start, @function
_start:
	andq	$-16, %rsp
	pushq	%rbp
	movq	%rsp, %rbp
	leaq	.Lbuf_out(%rip), %rdi
	leaq	.Lbuf_in(%rip), %rsi
	WRITE_PROMPT
	READ_BUF_IN
	ASCII_TO_HEX
	INS_TOTAL_LEN
	INS_COL_RES
	CALC_OUT_LEN
	WRITE_BUF_OUT
	EXIT
	.size	_start, .-_start


	.section	.rodata.str1.1,"aMS",@progbits,1
	.type	.LChex_table, @object
.LChex_table:
	.ascii	"0123456789ABCDEF" 
	.size	.LChex_table, .-.LChex_table

	.type	.LCprompt, @object
.LCprompt:
	.ascii	"\033[33mAview by OrangeCore.\n"
	.ascii	"ASCII:\n\033[35m"
	.equ	.LCPROMPT_LEN, .-.LCprompt
	.size	.LCprompt, .LCPROMPT_LEN


	.section	.bss,"aw",@nobits
	.type	.Lbuf_in, @object
.Lbuf_in:
	.zero	BUF_IN_SIZE
	.size	.Lbuf_in, BUF_IN_SIZE

	.type	.Lbuf_out, @object
.Lbuf_out:
	.zero	BUF_OUT_SIZE
	.size	.Lbuf_out, BUF_OUT_SIZE
