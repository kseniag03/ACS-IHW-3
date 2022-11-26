	.file	"file_input.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"Unable to open file '%s'\n"
.LC2:
	.string	"%lf"
.LC3:
	.string	"Reading file '%s' error\n"
.LC4:
	.string	"Epsilon is too big. Max epsilon = %lf\n"
	.text
	.globl	file_input
	.type	file_input, @function
file_input:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rdi, %r13
	movq	%rdx, %rdi
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	leaq	.LC0(%rip), %rsi
	pushq	%rcx
	.cfi_def_cfa_offset 48
	call	fopen@PLT
	testq	%rax, %rax
	jne	.L2
	movq	%r12, %rdx
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L12
.L2:
	movq	%r13, %rdx
	leaq	.LC2(%rip), %r13
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%eax, %eax
	call	__isoc99_fscanf@PLT
	testl	%eax, %eax
	jle	.L13
	xorl	%eax, %eax
	movq	%rbx, %rdx
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	__isoc99_fscanf@PLT
	testl	%eax, %eax
	jg	.L5
.L13:
	movq	%r12, %rdx
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L11
.L5:
	movsd	MAX_EPS(%rip), %xmm0
	movsd	(%rbx), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L9
	leaq	.LC4(%rip), %rsi
	movl	$1, %edi
	movb	$1, %al
	call	__printf_chk@PLT
.L11:
	movq	%rbp, %rdi
	call	fclose@PLT
.L12:
	movl	$1, %eax
	jmp	.L1
.L9:
	movq	%rbp, %rdi
	call	fclose@PLT
	xorl	%eax, %eax
.L1:
	popq	%rdx
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
	.size	file_input, .-file_input
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
