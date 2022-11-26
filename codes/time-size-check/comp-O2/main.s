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
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC7:
	.string	"Epsilon is too big. Max epsilon = %lf\n"
	.section	.rodata.str1.1
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
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L2
	leaq	.LC1(%rip), %r14
	leaq	.LC0(%rip), %r12
	cmpl	$2, %edi
	je	.L3
	movq	16(%rsi), %r14
	cmpl	$3, %edi
	je	.L3
	movq	24(%rsi), %r12
.L3:
	movq	8(%rsi), %r13
	movl	$1, %edi
	xorl	%eax, %eax
	leaq	.LC2(%rip), %rsi
	movq	%r13, %rdx
	call	__printf_chk@PLT
	movq	%r13, %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movl	%eax, %r13d
	cmpl	$1, %eax
	je	.L20
	leaq	8(%rsp), %rsi
	movq	%rsp, %rdi
	cmpl	$2, %eax
	je	.L21
	call	random_generation@PLT
.L18:
	movsd	8(%rsp), %xmm1
.L9:
	movsd	(%rsp), %xmm0
	movl	$1, %edi
	leaq	.LC9(%rip), %rsi
	movl	$2, %eax
	leaq	.LC12(%rip), %r13
	leaq	.LC13(%rip), %rbp
	call	__printf_chk@PLT
	leaq	32(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movsd	8(%rsp), %xmm1
	movsd	(%rsp), %xmm0
	leaq	24(%rsp), %rsi
	movq	$0x000000000, 16(%rsp)
	leaq	16(%rsp), %rdi
	movq	$0x000000000, 24(%rsp)
	call	power_series@PLT
	leaq	48(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rcx
	movq	32(%rsp), %rdx
	movq	48(%rsp), %rdi
	movq	56(%rsp), %rsi
	call	timespec_difference@PLT
	leaq	.LC11(%rip), %rsi
	movl	$1, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movsd	16(%rsp), %xmm0
	movq	%r13, %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	movsd	24(%rsp), %xmm0
	movq	%rbp, %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	movq	%r13, %rdi
	movq	%r12, %rdx
	movq	%rbp, %rsi
	movsd	24(%rsp), %xmm1
	movsd	16(%rsp), %xmm0
	xorl	%r13d, %r13d
	call	file_output@PLT
.L1:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L22
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	%r13d, %eax
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L21:
	.cfi_restore_state
	movq	%r14, %rdx
	call	file_input@PLT
	testl	%eax, %eax
	je	.L18
	movl	$1, %r13d
	jmp	.L1
.L20:
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC4(%rip), %rbp
	movq	%rsp, %rsi
	xorl	%eax, %eax
	movq	%rbp, %rdi
	call	__isoc99_scanf@PLT
	leaq	.LC5(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	leaq	8(%rsp), %rsi
	movq	%rbp, %rdi
	call	__isoc99_scanf@PLT
	movsd	.LC6(%rip), %xmm0
	movsd	8(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L9
	leaq	.LC7(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	jmp	.L1
.L2:
	leaq	.LC8(%rip), %rdi
	xorl	%r13d, %r13d
	call	puts@PLT
	jmp	.L1
.L22:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE39:
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
