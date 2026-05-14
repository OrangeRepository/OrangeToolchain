# ====================================================
# ==== Written by ==== OrangeCore ==== Since 2026 ====
# ====================================================
#       Suffer.
# ====================================================
# ========== THERE'S NO DOCUMENTATION BELOW ==========
# ====================================================


#############################################
#                                           #
#  Macros                                   #
#                                           #
#############################################
	.equ	SYS_WRITE, 1
	.equ	STDOUT, 1
	.equ	SYS_EXIT, 60
	.macro PUSH_ALL
		pushq	%rax; pushq	%rbx;
		pushq	%rcx; pushq	%rdx;
		pushq	%rsi; pushq	%rdi;
		pushq	%rsp; pushq	%rbp;
		pushq	%r8;  pushq	%r9;
		pushq	%r10; pushq	%r11;
		pushq	%r12; pushq	%r13;
		pushq	%r14; pushq	%r15;
	.endm
	.macro POP_ALL
		popq	%r15; popq	%r14;
		popq	%r13; popq	%r12;
		popq	%r11; popq	%r10;
		popq	%r9;  popq	%r8;
		popq	%rbp; popq	%rsp;
		popq	%rdi; popq	%rsi;
		popq	%rdx; popq	%rcx;
		popq	%rbx; popq	%rax;
	.endm
	.macro SYSCALL_PUSH
		pushq	%rax
		pushq	%rdi
		pushq	%rsi
		pushq	%rdx
		pushq	%rcx
		pushq	%r11
	.endm
	.macro SYSCALL_POP
		popq	%r11
		popq	%rcx
		popq	%rdx
		popq	%rsi
		popq	%rdi
		popq	%rax
	.endm


#############################################
#                                           #
#  Section: Text                            #
#                                           #
#############################################
	.section	.text,"ax",@progbits
#############################################
#                                           #
#  Generic Functions                        #
#                                           #
#############################################
#
#  FUNCTION : ins_red_color
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.type	.Lins_red_color, @function
.Lins_red_color:
	movl	$0x31335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	.Lins_red_color, . - .Lins_red_color

#############################################
#
#  FUNCTION : ins_yellow_color
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.type	.Lins_yellow_color, @function
.Lins_yellow_color:
	movl	$0x33335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	.Lins_yellow_color, . - .Lins_yellow_color

#############################################
#
#  FUNCTION : ins_purple_color
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.type	.Lins_purple_color, @function
.Lins_purple_color:
	movl	$0x35335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	.Lins_purple_color, . - .Lins_purple_color

#############################################
#
#  FUNCTION : ins_cyan_color
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.type	.Lins_cyan_color, @function
.Lins_cyan_color:
	movl	$0x36335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	.Lins_cyan_color, . - .Lins_cyan_color

#############################################
#
#  FUNCTION : ins_color_reset
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.type	.Lins_color_reset, @function
.Lins_color_reset:
	movl	$0x6D305B1B, (%rdi)
	addq	$4, %rdi
	ret
	.size	.Lins_color_reset, . - .Lins_color_reset

#############################################
#
#  FUNCTION : write - writes into $FD
#  INPUT    : %RDI - $FD
#             %RSI - *src
#             %RDX - $len
#  OUTPUT   : $FD - data
#  DESTROYS : %RAX, %RCX, %R11
#  CALLS    : syscall
#
	.p2align 4
	.type	.Lwrite, @function
.Lwrite:
	movq	$SYS_WRITE, %rax
	syscall
	ret
	.size	.Lwrite, . - .Lwrite

#############################################
#
#  FUNCTION : exit - exits the program
#  INPUT    : %RDI - $exit-code
#  OUTPUT   : none
#  DESTROYS : none
#  CALLS    : syscall
#
	.p2align 4
	.type	.Lexit, @function
.Lexit:
	movq	$SYS_EXIT, %rax
	syscall
	.size	.Lexit, . - .Lexit

#############################################
#
#  FUNCTION : memcpy - copies one
#             memory address into
#             another memory address
#  INPUT    : %RDI - *dest
#             %RSI - *src
#             %RDX - $len
#  OUTPUT   : %RAX - *dest-original
#  DESTROYS : %RAX, %RCX,
#             %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
	.type	.Lmemcpy, @function
.Lmemcpy:
	movq	%rdi, %rax
	movq	%rdx, %rcx
	rep movsb
	ret
	.size	.Lmemcpy, . - .Lmemcpy

#############################################
#
#  FUNCTION : htoa - hex to ASCII
#  INPUT    : %RDI - *dest
#             %RSI - $src
#             %RDX - $amount-of-hex-digits
#  OUTPUT   : %RAX - *dest-original
#             ON-ERROR: %RAX - $return-code
#  DESTROYS : %RAX, %RDX, %RCX,
#             %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
	.type	.Lhtoa, @function
.Lhtoa:
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
	leaq	.LChex_table(%rip), %rsi
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
	.size	.Lhtoa, . - .Lhtoa

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
	.type	.Litoa, @function
.Litoa:
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
	.size	.Litoa, . - .Litoa

#############################################
#
#  FUNCTION : strlen - get string length
#  INPUT    : %RDI - *null-terminated-string
#  OUTPUT   : %RAX - $str-len-no-null
#  DESTROYS : %RAX, %RCX,
#             %RDX, %RDI
#  CALLS    : none
#
	.p2align 4
	.type	.Lstrlen, @function
.Lstrlen:
	movq	%rdi, %rdx
	movq	$-1, %rcx
	xorq	%rax, %rax
	repne scasb
 	decq	%rdi
	subq	%rdx, %rdi
	movq	%rdi, %rax
	ret
	.size	.Lstrlen, . - .Lstrlen

#############################################
#
#  FUNCTION : memset - memory set.
#             fills specified memory
#             region with a byte value
#  INPUT    : %RDI - *dest
#             %RSI - $byte
#             %RDX - $len
#  OUTPUT   : %RAX - *dest-original
#  DESTROYS : %RAX, %RCX, %RDI
#  CALLS    : none
#
	.p2align 4
	.type	.Lmemset, @function
.Lmemset:
	pushq	%rdi
	movb	%sil, %al
	movq	%rdx, %rcx
	rep stosb
	popq	%rax
	ret
	.size	.Lmemset, . - .Lmemset

#############################################
#                                           #
#  Custom Functions                         #
#                                           #
#############################################
#
#  FUNCTION : save_regs
#  INPUT    : none
#  OUTPUT   : none
#  DESTROYS : %RSI, %RDI
#  CALLS    : none
#
	.p2align 4
.Lsave_regs:
	pushq	%rdi
	leaq	.Lbuf_values(%rip), %rdi
	movq	%rax, (%rdi)
	movq	%rbx, 8(%rdi)
	movq	%rcx, 16(%rdi)
	movq	%rdx, 24(%rdi)
	movq	%rsi, 32(%rdi)
	#
	# %RSI instead of %RDI, 
	# since we already have
	# the buffer address in %RDI
	#
	popq	%rsi
	movq	%rsi, 40(%rdi)
	movq	%rsp, 48(%rdi)
	movq	%rbp, 56(%rdi)
	movq	%r8, 64(%rdi)
	movq	%r9, 72(%rdi)
	movq	%r10, 80(%rdi)
	movq	%r11, 88(%rdi)
	movq	%r12, 96(%rdi)
	movq	%r13, 104(%rdi)
	movq	%r14, 112(%rdi)
	movq	%r15, 120(%rdi)
	ret

#############################################
#
#  FUNCTION : ins_reg_pfx
#  INPUT    : %RDI - *dest
#             %RSI - *register-table
#             EXAMPLE:
#             "| RAX | | RBX | ..."
#  OUTPUT   : none
#  DESTROYS : %RAX, %RSI, %RDI
#  CALLS    : ins_purple_color,
#             ins_yellow_color
#
	.p2align 4
.Lins_reg_pfx:
	#
	# "| "
	# (format: little-endian)
	#
	movw	(%rsi), %ax
	movw	%ax, (%rdi)
	addq	$2, %rsi
	addq	$2, %rdi
	#
	# ANSI-PURPLE + "??? "
	#
	call	.Lins_purple_color
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
	addq	$4, %rsi
	addq	$4, %rdi
	#
	# ANSI-YELLOW + "| "
	#
	call	.Lins_yellow_color
	movw	(%rsi), %ax
	movw	%ax, (%rdi)
	addq	$2, %rsi
	addq	$2, %rdi
	ret

#############################################
#
#  FUNCTION : calculate_hex
#  INPUT    : %RDI- $src
#  OUTPUT   : %RAX - $
#  DESTROYS : %RAX
#  CALLS    : none
#
	.p2align 4
.Lcalculate_hex:
	testq	%rdi, %rdi
	jz	.Lcalculate_hex_zero
	movq	$16, %rax
	ret
.Lcalculate_hex_zero:
	movq	$1, %rax
	ret

#############################################
#
#  FUNCTION : close_border - 
#  INPUT    : %RDI - *dest
#             %RSI - $amount-of-spaces
#  OUTPUT   : none
#  DESTROYS : %RAX, %RCX, %RDI
#  CALLS    : none
#
	.p2align 4
.Lclose_border:
	movq	%rsi, %rcx
.Lclose_border_loop:
	movb	$0x20, (%rdi)
	incq	%rdi
	decq	%rcx
	jnz	.Lclose_border_loop
	call	.Lins_yellow_color
	movw	$0x207C, (%rdi)
	addq	$2, %rdi
	ret

#############################################
#
#  FUNCTION : ins_newline - inserts
#             a newline in the specified
#             buffer
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
.Lins_newline:
	movb	$0x0A, (%rdi)
	incq	%rdi
	ret

#############################################
#
#  FUNCTION : calculate_spaces -
#             calculates requirement
#             amount of spaces based
#             on the specified width
#  INPUT    : %RDI - *current-address
#             %RSI - *original-address
#             %RDX - $cell-width
#  OUTPUT   : %RAX - $amount-of-spaces
#  DESTROYS : %RAX, %RDX
#  CALLS    : none
#
.Lcalculate_spaces:
	movq	%rdi, %rax
	subq	%rsi, %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	ret

#############################################
#
#  FUNCTION : close_border - closes
#             the table border with
#             specified amount of
#             spaces and "|" in
#             the end
#  INPUT    : %RDI - *dest
#             %RSI - $amount-of-spaces
#  OUTPUT   : none
#  DESTROYS : %RCX, %RSI, %RDI
#  CALLS    : ins_yellow_color
#
.Lclose_last_border:
	movq	%rsi, %rcx
.Lclose_last_border_loop:
	movb	$' ', (%rdi)
	incq	%rdi
	decq	%rcx
	jnz	.Lclose_last_border_loop
	call	.Lins_yellow_color
	movb	$0x7C, (%rdi)
	incq	%rdi
	ret

#############################################
#
#  FUNCTION : sfr_dbpoint - writes
#             the debug point
#  INPUT    : none
#  OUTPUT   : none
#  DESTROYS : none
#  CALLS    : write
#
	.p2align 4
	.global sfr_dbpoint
	.type	sfr_dbpoint, @function
sfr_dbpoint:
	SYSCALL_PUSH
	movq	$1, %rdi
	leaq	.LCdbpoint(%rip), %rsi
	movq	$DBPOINT_LEN, %rdx
	call	.Lwrite
	SYSCALL_POP
	ret
	.size	sfr_dbpoint, . - sfr_dbpoint

#
# L
#
.Ldraw_row:	# L3
	movq	%r14, %rsi
	call	.Lins_reg_pfx		# L2
	call	.Lins_cyan_color	# L1
	#
	pushq	%rdi
	movq	(%r13), %rdi
	call	.Lcalculate_hex		# L2
	popq	%rdi
	#
	pushq	%rdi
	movq	(%r13), %rsi
	movq	%rax, %rdx
	call	.Lhtoa			# L1
	popq	%rsi
	addq	$3, %rsi
	#
	movq	$16, %rdx
	call	.Lcalculate_spaces	# L2
	#
	movq	%rax, %rsi
	call	.Lclose_border		# L2
	#
	call	.Lins_red_color		# L1
	#
	pushq	%rdi
	movq	(%r13), %rsi
	call	.Litoa			# L1
	popq	%rsi
	#
	movq	$21, %rdx
	call	.Lcalculate_spaces	# L2
	#
	movq	%rax, %rsi
	call	.Lclose_last_border	# L2
	#
	call	.Lins_newline		# L2
	#
	addq	$8, %r14
	addq	$8, %r13
	ret

#############################################
#
#  FUNCTION : sfr_reg_dump - dumps
#             all the 16 general
#             purpose registers +
#             decimal view
#  INPUT    : none
#  OUTPUT   : none
#  DESTROYS : none
#  CALLS    : a lot
#
	.p2align 4
	.global sfr_reg_dump
	.type	sfr_reg_dump, @function
sfr_reg_dump:
	PUSH_ALL
	call	.Lsave_regs
	leaq	.Lbuf_out(%rip), %rdi
	movq	$16, %r12
	leaq	.Lbuf_values(%rip), %r13
	leaq	.LCreg_pfxs(%rip), %r14
	#
	leaq	.LCdump_header(%rip), %rsi
	movq	$DUMP_HEADER_LEN, %rdx
	call	.Lmemcpy
	#
	call	.Ldraw_row
	call	.Ldraw_row
	call	.Ldraw_row
	call	.Ldraw_row
	#
	call	.Ldraw_row
	call	.Ldraw_row
	call	.Ldraw_row
	call	.Ldraw_row
	#
	call	.Ldraw_row
	call	.Ldraw_row
	call	.Ldraw_row
	call	.Ldraw_row
	#
	call	.Ldraw_row
	call	.Ldraw_row
	call	.Ldraw_row
	call	.Ldraw_row
	#
	leaq	.LCdump_footer(%rip), %rsi
	movq	$DUMP_FOOTER_LEN, %rdx
	call	.Lmemcpy
	#
	call	.Lins_color_reset
	#
	leaq	.Lbuf_out(%rip), %rdi
	call	.Lstrlen
	pushq	%rax
	#
	movq	$STDOUT, %rdi
	leaq	.Lbuf_out(%rip), %rsi
	movq	%rax, %rdx
	call	.Lwrite
	#
	leaq	.Lbuf_out(%rip), %rdi
	movq	$0, %rsi
	popq	%rdx
	call	.Lmemset
	#
	POP_ALL
	ret
	.size	sfr_reg_dump, . - sfr_reg_dump

	.p2align 4
	.global	sfr_mem_inspect
	.type	sfr_mem_inspect, @function
sfr_mem_inspect:
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	$1, %rdi
	call	.Lwrite
	ret
	.size	sfr_mem_inspect, . - sfr_mem_inspect

	.p2align 4
	.global	sfr_seg_inspect
	.type	sfr_seg_inspect, @function
sfr_seg_inspect:
	SYSCALL_PUSH
	#
	movl	$STDOUT, %edi
	leaq	.LCseg_inspect_start(%rip), %rsi
	movl	$SEG_INSPECT_START_LEN, %edx
	call	.Lwrite
	#
	SYSCALL_POP
	#
	movq	$0, (%rdi)
	#
	SYSCALL_PUSH
	#
	movl	$STDOUT, %edi
	leaq	.LCseg_inspect_end(%rip), %rsi
	movl	$SEG_INSPECT_END_LEN, %edx
	call	.Lwrite
	#
	SYSCALL_POP
	ret
	.size	sfr_seg_inspect, . - sfr_seg_inspect

#############################################
#                                           #
#  Section: Better Save Space!              #
#                                           #
#############################################
	.section	.bss,"aw",@nobits
#
# Buffer for all register values
#
	.p2align 4
	.type	.Lbuf_values, @object
.Lbuf_values:
	.zero	128
	.size	.Lbuf_values, 128

	.type	.Lbuf_out, @object
.Lbuf_out:
	.zero	2048
	.size	.Lbuf_out, 2048


#############################################
#                                           #
#  Section: Read-Only Data                  #
#                                           #
#############################################
	.section	.rodata.str1.1,"aMS",@progbits,1
	.type	.LCdbpoint, @object
.LCdbpoint:
	.ascii	"\033[33m[Suffer] Point was reached!\033[0m\n"
	.equ	DBPOINT_LEN, . - .LCdbpoint
	.size	.LCdbpoint, DBPOINT_LEN

.LCdump_header:
	.ascii	"\033[33m"
	.ascii	"+-------------------------------------------------+\n"
	.ascii	"| Suffer ========== OrangeCore ======== Regs dump |\n"
	.ascii	"+-----+--------------------+----------------------+\n"
	.ascii	"|\033[35m REG\033[33m |\033[36m HEXADECIMAL       \033[33m |\033[31m DECIMAL             \033[33m |\n"
	.ascii	"+-----+--------------------+----------------------+\n"
	.equ	DUMP_HEADER_LEN, . - .LCdump_header

	.type	.LCreg_pfxs, @object
.LCreg_pfxs:
	.ascii	"| RAX | | RBX | | RCX | | RDX | | RSI | | RDI | | RSP | | RBP | | R8  | | R9  | | R10 | | R11 | | R12 | | R13 | | R14 | | R15 | "
	.size	.LCreg_pfxs, . - .LCreg_pfxs

	.type	.LChex_table, @object
.LChex_table:
	.ascii	"0123456789ABCDEF"
	.size	.LChex_table, . - .LChex_table

.LCdump_footer:
	.ascii	"+-----+--------------------+----------------------+\n"
	.equ	DUMP_FOOTER_LEN, . - .LCdump_footer

.LCseg_inspect_start:
	.ascii	"\033[33m[Suffer] Checking for a segfault...\033[0m\n"
	.equ	SEG_INSPECT_START_LEN, . - .LCseg_inspect_start
.LCseg_inspect_end:
	.ascii	"\033[33m[Suffer] No segfault, the specified memory is correct!\033[0m\n"
	.equ	SEG_INSPECT_END_LEN, . - .LCseg_inspect_end
