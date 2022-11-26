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
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"Epsilon is too big. Max epsilon = %lf\n"
	.text
	.globl	file_input
	.type	file_input, @function
file_input:
.LFB23:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, %r13
	movq	%rsi, %r12
	movq	%rdx, %rbp
	leaq	.LC0(%rip), %rsi
	movq	%rdx, %rdi
	call	fopen@PLT
	testq	%rax, %rax
	je	.L11
	movq	%rax, %rbx
	movq	%r13, %rdx
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_fscanf@PLT
	testl	%eax, %eax
	jle	.L12
	movq	%r12, %rdx
	leaq	.LC2(%rip), %rsi
	movq	%rbx, %rdi
	movl	$0, %eax
	call	__isoc99_fscanf@PLT
	testl	%eax, %eax
	jle	.L13
	movsd	MAX_EPS(%rip), %xmm0
	movsd	(%r12), %xmm1
	comisd	%xmm0, %xmm1
	ja	.L14
	movq	%rbx, %rdi
	call	fclose@PLT
	movl	$0, %eax
.L1:
	addq	$8, %rsp
	.cfi_remember_state
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
.L11:
	.cfi_restore_state
	movq	%rbp, %rdx
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$1, %eax
	jmp	.L1
.L12:
	movq	%rbp, %rdx
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rdi
	call	fclose@PLT
	movl	$1, %eax
	jmp	.L1
.L13:
	movq	%rbp, %rdx
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rdi
	call	fclose@PLT
	movl	$1, %eax
	jmp	.L1
.L14:
	leaq	.LC4(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rdi
	call	fclose@PLT
	movl	$1, %eax
	jmp	.L1
	.cfi_endproc
.LFE23:
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
