	.file	"main.c"
	.text
	.globl	BERNOULLI
	.bss
	.align 32
	.type	BERNOULLI, @object
	.size	BERNOULLI, 8000
BERNOULLI:
	.zero	8000
	.globl	MAX_EPS
	.section	.rodata
	.align 8
	.type	MAX_EPS, @object
	.size	MAX_EPS, 8
MAX_EPS:
	.long	-1717986918
	.long	1068079513
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
	.align 8
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
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160, %rsp
	movl	%edi, -148(%rbp)
	movq	%rsi, -160(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -96(%rbp)
	movq	$0, -88(%rbp)
	cmpl	$1, -148(%rbp)
	jle	.L2
	cmpl	$2, -148(%rbp)
	jg	.L3
	leaq	.LC0(%rip), %rax
	movq	%rax, -96(%rbp)
	jmp	.L4
.L3:
	movq	-160(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -96(%rbp)
.L4:
	cmpl	$3, -148(%rbp)
	jg	.L5
	leaq	.LC1(%rip), %rax
	movq	%rax, -88(%rbp)
	jmp	.L6
.L5:
	movq	-160(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -88(%rbp)
.L6:
	movq	-160(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -136(%rbp)
	cmpl	$1, -136(%rbp)
	jne	.L7
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-128(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-120(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movsd	-120(%rbp), %xmm0
	movsd	.LC6(%rip), %xmm1
	comisd	%xmm1, %xmm0
	jbe	.L8
	movq	.LC6(%rip), %rax
	movq	%rax, %xmm0
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L12
.L7:
	cmpl	$2, -136(%rbp)
	jne	.L11
	movq	-96(%rbp), %rdx
	leaq	-120(%rbp), %rcx
	leaq	-128(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	file_input@PLT
	movl	%eax, -132(%rbp)
	cmpl	$0, -132(%rbp)
	je	.L8
	movl	$1, %eax
	jmp	.L12
.L11:
	leaq	-120(%rbp), %rdx
	leaq	-128(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	random_generation@PLT
	jmp	.L8
.L2:
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L12
.L8:
	movsd	-120(%rbp), %xmm0
	movq	-128(%rbp), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	movl	$2, %eax
	call	printf@PLT
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -112(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -104(%rbp)
	movsd	-120(%rbp), %xmm0
	movq	-128(%rbp), %rax
	leaq	-104(%rbp), %rcx
	leaq	-112(%rbp), %rdx
	movq	%rcx, %rsi
	movq	%rdx, %rdi
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	power_series@PLT
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	-48(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	call	timespec_difference@PLT
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC11(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC12(%rip), %rax
	movq	%rax, -64(%rbp)
	leaq	.LC13(%rip), %rax
	movq	%rax, -56(%rbp)
	movq	-112(%rbp), %rdx
	movq	-64(%rbp), %rax
	movq	%rdx, %xmm0
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movq	-104(%rbp), %rdx
	movq	-56(%rbp), %rax
	movq	%rdx, %xmm0
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movsd	-104(%rbp), %xmm0
	movq	-112(%rbp), %rax
	movq	-88(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-64(%rbp), %rcx
	movq	%rcx, %rdi
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	file_output@PLT
	movl	$0, %eax
.L12:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
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
