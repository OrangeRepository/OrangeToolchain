#
# Make this bitch more reliable.
# Now, argc and argv functions
# are really fragile, and can
# suddenly break. FIX THIS!
#


	.equ	STDIN, 0
	.equ	STDOUT, 1
	.equ	BUF_SRC_SIZE, 65536


	.extern	sfr_reg_dump


	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : err_argc_nequal - outputs
#             the error message
#  INPUT    : none
#  OUTPUT   : none
#  DESTROYS : none
#  CALLS    : write, exit
#
err_argc_nequal:
	movq	$STDOUT, %rdi
	leaq	errmsg_argc_nequal(%rip), %rsi
	movq	$ERRMSG_ARGC_NEQUAL_LEN, %rdx
	call	write
	#
	movq	$-1, %rdi
	jmp	exit

#############################################
#
#  FUNCTION : clear_screen - clears
#             the entire screen
#  INPUT    : %RDI - *sequence-struct
#  OUTPUT   : none
#  DESTROYS : %RAX, %RCX, %RSI,
#             %RDX, %R11
#  CALLS    : write
#
clear_screen:
	pushq	%rbx
	pushq	%rdi
	movq	%rdi, %rbx
	movq	$STDOUT, %rdi
	movq	16(%rbx), %rsi
	movq	24(%rbx), %rdx
	call	write
	#
	movq	0(%rbx), %rsi
	movq	8(%rbx), %rdx
	call	write
	#
	popq	%rdi
	popq	%rbx
	#
	ret

#############################################
#
#  FUNCTION : get_argc - gets $argc
#  INPUT    : %RDI - *rsp-default
#  OUTPUT   : %RAX - $argc
#  DESTROYS : %RAX
#  CALLS    : none
#
get_argc:
	movq	0(%rdi), %rax
	ret

#############################################
#
#  FUNCTION : get_argv - gets *argv
#  INPUT    : %RDI - *argv-struct
#             %RSI - *rsp-default
#             %RDX - $argc
#  OUTPUT   : %RAX - *argv-struct
#  DESTROYS : %RAX, %RCX, %RDI
#  CALLS    : none
#
get_argv:
	pushq	%rdi
	#
	addq	$8, %rsi
	movq	%rdx, %rcx
.Lget_argv_loop:
	#
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	#
	addq	$8, %rsi
	addq	$8, %rdi
	#
	decq	%rcx
	jnz	.Lget_argv_loop
	#
	popq	%rax
	ret

	.global	_start
_start:
	movq	%rsp, %rbp
	#
	# Parsing ARGC
	#
	movq	%rbp, %rdi
	call	get_argc
	cmpq	$2, %rax
	jne	err_argc_nequal
	#
	# Parsing ARGV
	#
	leaq	struct_argv(%rip), %rdi
	movq	%rbp, %rsi
	movq	%rax, %rdx
	call	get_argv
	#
	# Getting the source filename
	#
	leaq	filename(%rip), %rdi
	movq	8(%rax), %rsi
	call	strcpy
	#
	# Clearing the screen
	#
	leaq	struct_sequence(%rip), %rdi
	call	clear_screen
	#
	# Reading into buffer
	#
	movq	$STDIN, %rdi
	leaq	buf_src(%rip), %rsi
	movq	$BUF_SRC_SIZE, %rdx
	call	read
	movq	%rax, %r15
	#
	# Opening file
	#
	leaq	filename(%rip), %rdi
	movq	$2, %rsi
	xorq	%rdx, %rdx
	call	open
	movq	%rax, fd
	#
	# Writing into the buffer
	#
	movq	fd, %rdi
	leaq	buf_src(%rip), %rsi
	movq	%r15, %rdx
	call	write
	#
	# Closing file
	#
	movq	fd, %rdi
	call	close
	#
	# Leaving this shi
	#
	jmp	exit


	.section	.data,"aw",@progbits
struct_argv:
	.quad	0
	.quad	0

filename:
	.quad	0
fd:
	.quad	0


	.section	.rodata.str1.1,"aMS",@progbits,1
errmsg_argc_nequal:
	.ascii	"\033[33m[Stinger]\033[31m error:\033[33m allowed number of arguments: 2\033[0m"
	.equ	ERRMSG_ARGC_NEQUAL_LEN, . - errmsg_argc_nequal

struct_sequence:
	.quad	move_cursor_home
	.quad	MOVE_CURSOR_HOME_LEN
	.quad	erase_screen
	.quad	ERASE_SCREEN_LEN

move_cursor_home:
	.ascii	"\033[H"
	.equ	MOVE_CURSOR_HOME_LEN, . - move_cursor_home
erase_screen:
	.ascii	"\033[2J"
	.equ	ERASE_SCREEN_LEN, . - erase_screen


	.section	.bss,"aw",@nobits
buf_src:
	.zero	BUF_SRC_SIZE
