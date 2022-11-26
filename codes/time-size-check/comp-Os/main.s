	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"output.txt"
.LC1:
	.string	"input.txt"
.LC2:
	.string	"arg = %s\n"
.LC3:
	.string	"Enter x:"
.LC4:
	.string	"%lf"
.LC5:
	.string	"Enter eps:"
.LC7:
	.string	"Epsilon is too big. Max epsilon = %lf\n"
.LC8:
	.string	"No arguments"
.LC9:
	.string	"Input value: %lf, eps: %lf\n"
.LC11:
	.string	"Elapsed: %ld ns\n"
.LC12:
	.string	"Approximate Value: %lf\n"
.LC13:
	.string	"Error: %lf\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	subq	$80, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L2
	leaq	.LC1(%rip), %r15
	leaq	.LC0(%rip), %r13
	cmpl	$2, %edi
	je	.L3
	movq	16(%rsi), %r15
	cmpl	$3, %edi
	je	.L3
	movq	24(%rsi), %r13
.L3:
	movq	8(%rsi), %rbp
	movl	$1, %edi
	xorl	%eax, %eax
	leaq	16(%rsp), %r14
	leaq	.LC2(%rip), %rsi
	movq	%rbp, %rdx
	call	__printf_chk@PLT
	movq	%rbp, %rdi
	leaq	8(%rsp), %rbp
	call	atoi@PLT
	cmpl	$1, %eax
	movl	%eax, %r12d
	jne	.L4
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%rbp, %rsi
	leaq	.LC4(%rip), %rbp
	xorl	%eax, %eax
	movq	%rbp, %rdi
	call	__isoc99_scanf@PLT
	leaq	.LC5(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%rbp, %rdi
	call	__isoc99_scanf@PLT
	movsd	.LC6(%rip), %xmm0
	movsd	16(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L9
	leaq	.LC7(%rip), %rsi
	movl	$1, %edi
	movb	$1, %al
	call	__printf_chk@PLT
	jmp	.L1
.L4:
	cmpl	$2, %eax
	jne	.L8
	movq	%r15, %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movl	$1, %r12d
	call	file_input@PLT
	testl	%eax, %eax
	je	.L9
	jmp	.L1
.L8:
	movq	%r14, %rsi
	movq	%rbp, %rdi
	call	random_generation@PLT
	jmp	.L9
.L2:
	leaq	.LC8(%rip), %rdi
	call	puts@PLT
	jmp	.L18
.L9:
	movsd	16(%rsp), %xmm1
	movsd	8(%rsp), %xmm0
	leaq	.LC9(%rip), %rsi
	movb	$2, %al
	movl	$1, %edi
	leaq	.LC12(%rip), %rbp
	leaq	.LC13(%rip), %r12
	call	__printf_chk@PLT
	leaq	40(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movsd	16(%rsp), %xmm1
	movsd	8(%rsp), %xmm0
	leaq	32(%rsp), %rsi
	movq	$0x000000000, 24(%rsp)
	leaq	24(%rsp), %rdi
	movq	$0x000000000, 32(%rsp)
	call	power_series@PLT
	leaq	56(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	48(%rsp), %rcx
	movq	40(%rsp), %rdx
	movq	56(%rsp), %rdi
	movq	64(%rsp), %rsi
	call	timespec_difference@PLT
	leaq	.LC11(%rip), %rsi
	movl	$1, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movsd	24(%rsp), %xmm0
	movq	%rbp, %rsi
	movb	$1, %al
	movl	$1, %edi
	call	__printf_chk@PLT
	movsd	32(%rsp), %xmm0
	movq	%r12, %rsi
	movb	$1, %al
	movl	$1, %edi
	call	__printf_chk@PLT
	movq	%r13, %rdx
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movsd	32(%rsp), %xmm1
	movsd	24(%rsp), %xmm0
	call	file_output@PLT
.L18:
	xorl	%r12d, %r12d
.L1:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	je	.L10
	call	__stack_chk_fail@PLT
.L10:
	addq	$80, %rsp
	.cfi_def_cfa_offset 48
	movl	%r12d, %eax
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.globl	MAX_EPS
	.section	.rodata
	.align 8
	.type	MAX_EPS, @object
	.size	MAX_EPS, 8
MAX_EPS:
	.long	-1717986918
	.long	1068079513
	.globl	BERNOULLI
	.bss
	.align 32
	.type	BERNOULLI, @object
	.size	BERNOULLI, 8000
BERNOULLI:
	.zero	8000
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC6:
	.long	-1717986918
	.long	1068079513
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
