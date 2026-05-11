# ====================================================
# ==== Written by ==== OrangeCore ==== Since 2026 ====
# ====================================================
#       Add some colors into your world!
# ====================================================
# ========== THERE'S NO DOCUMENTATION BELOW ==========
# ====================================================


	.section	.text,"ax",@progbits
#############################################
#
#  FUNCTION : Xins_ansi_color
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xins_ansi_black
	.type	Xins_ansi_black, @function
Xins_ansi_black:
	movl	$0x30335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	Xins_ansi_black, . - Xins_ansi_black

#############################################
#
#  FUNCTION : Xins_ansi_red
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xins_ansi_red
	.type	Xins_ansi_red, @function
Xins_ansi_red:
	movl	$0x31335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	Xins_ansi_red, . - Xins_ansi_red

#############################################
#
#  FUNCTION : Xins_ansi_green
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.global Xins_ansi_green
	.type	Xins_ansi_green, @function
Xins_ansi_green:
	movl	$0x32335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	Xins_ansi_green, . - Xins_ansi_green

#############################################
#
#  FUNCTION : Xins_ansi_yellow
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xins_ansi_yellow
	.type	Xins_ansi_yellow, @function
Xins_ansi_yellow:
	movl	$0x33335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	Xins_ansi_yellow, . - Xins_ansi_yellow

#############################################
#
#  FUNCTION : Xins_ansi_blue
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xins_ansi_blue
	.type	Xins_ansi_blue, @function
Xins_ansi_blue:
	movl	$0x34335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	Xins_ansi_blue, . - Xins_ansi_blue

#############################################
#
#  FUNCTION : Xins_ansi_purple
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xins_ansi_purple
	.type	Xins_ansi_purple, @function
Xins_ansi_purple:
	movl	$0x35335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	Xins_ansi_purple, . - Xins_ansi_purple

#############################################
#
#  FUNCTION : Xins_ansi_cyan
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xins_ansi_cyan
	.type	Xins_ansi_cyan, @function
Xins_ansi_cyan:
	movl	$0x36335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	Xins_ansi_cyan, . - Xins_ansi_cyan

#############################################
#
#  FUNCTION : Xins_ansi_white
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xins_ansi_white
	.type	Xins_ansi_white, @function
Xins_ansi_white:
	movl	$0x37335B1B, (%rdi)
	addq	$4, %rdi
	movb	$0x6D, (%rdi)
	incq	%rdi
	ret
	.size	Xins_ansi_white, . - Xins_ansi_white

#############################################
#
#  FUNCTION : Xins_ansi_reset
#  INPUT    : %RDI - *dest
#  OUTPUT   : none
#  DESTROYS : %RDI
#  CALLS    : none
#
	.p2align 4
	.global	Xins_ansi_reset
	.type	Xins_ansi_reset, @function
Xins_ansi_reset:
	movl	$0x6D305B1B, (%rdi)
	addq	$4, %rdi
	ret
	.size	Xins_ansi_reset, . - Xins_ansi_reset
