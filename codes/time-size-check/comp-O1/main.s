	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"input.txt"
.LC1:
	.string	"output.txt"
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
	.text
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$80, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L2
	leaq	.LC0(%rip), %rbp
	cmpl	$2, %edi
	jle	.L3
	movq	16(%rsi), %rbp
.L3:
	leaq	.LC1(%rip), %rbx
	cmpl	$3, %edi
	jle	.L4
	movq	24(%rsi), %rbx
.L4:
	movq	8(%rsi), %r12
	movq	%r12, %rdx
	leaq	.LC2(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$10, %edx
	movl	$0, %esi
	movq	%r12, %rdi
	call	strtol@PLT
	movl	%eax, %r12d
	cmpl	$1, %eax
	je	.L16
	cmpl	$2, %eax
	je	.L17
	leaq	8(%rsp), %rsi
	movq	%rsp, %rdi
	call	random_generation@PLT
.L6:
	movsd	8(%rsp), %xmm1
	movsd	(%rsp), %xmm0
	leaq	.LC9(%rip), %rsi
	movl	$1, %edi
	movl	$2, %eax
	call	__printf_chk@PLT
	leaq	32(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	$0x000000000, 16(%rsp)
	movq	$0x000000000, 24(%rsp)
	leaq	24(%rsp), %rsi
	leaq	16(%rsp), %rdi
	movsd	8(%rsp), %xmm1
	movsd	(%rsp), %xmm0
	call	power_series@PLT
	leaq	48(%rsp), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	32(%rsp), %rdx
	movq	40(%rsp), %rcx
	movq	48(%rsp), %rdi
	movq	56(%rsp), %rsi
	call	timespec_difference@PLT
	movq	%rax, %rdx
	leaq	.LC11(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movsd	16(%rsp), %xmm0
	leaq	.LC12(%rip), %rbp
	movq	%rbp, %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	movsd	24(%rsp), %xmm0
	leaq	.LC13(%rip), %r12
	movq	%r12, %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movsd	24(%rsp), %xmm1
	movsd	16(%rsp), %xmm0
	call	file_output@PLT
	movl	$0, %r12d
.L1:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L18
	movl	%r12d, %eax
	addq	$80, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L16:
	.cfi_restore_state
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rsp, %rsi
	leaq	.LC4(%rip), %rbp
	movq	%rbp, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	.LC5(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	8(%rsp), %rsi
	movq	%rbp, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movsd	8(%rsp), %xmm0
	comisd	.LC6(%rip), %xmm0
	jbe	.L6
	movsd	.LC6(%rip), %xmm0
	leaq	.LC7(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	jmp	.L1
.L17:
	leaq	8(%rsp), %rsi
	movq	%rsp, %rdi
	movq	%rbp, %rdx
	call	file_input@PLT
	testl	%eax, %eax
	je	.L6
	movl	$1, %r12d
	jmp	.L1
.L2:
	leaq	.LC8(%rip), %rdi
	call	puts@PLT
	movl	$0, %r12d
	jmp	.L1
.L18:
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
