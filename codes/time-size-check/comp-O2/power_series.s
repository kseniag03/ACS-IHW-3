	.file	"power_series.c"
	.text
	.p2align 4
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	endbr64
	movl	$1, %r8d
	cmpl	$1, %edi
	jbe	.L1
	movslq	%edi, %rdx
	leal	-2(%rdi), %esi
	movl	$1, %r8d
	leaq	-1(%rdx), %rax
	movq	%rax, %rcx
	subq	%rsi, %rcx
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L6:
	subq	$1, %rax
.L4:
	imulq	%rdx, %r8
	movq	%rax, %rdx
	cmpq	%rcx, %rax
	jne	.L6
.L1:
	movq	%r8, %rax
	ret
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.p2align 4
	.globl	th
	.type	th, @function
th:
.LFB1:
	.cfi_startproc
	endbr64
	testl	%edi, %edi
	jle	.L12
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pxor	%xmm2, %xmm2
	movq	%xmm0, %r14
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	leaq	BERNOULLI(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	leal	1(%rdi), %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	addq	%rbp, %rbp
	movl	$2, %ebx
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	.p2align 4,,10
	.p2align 3
.L10:
	pxor	%xmm1, %xmm1
	movq	.LC1(%rip), %rax
	movsd	%xmm2, 24(%rsp)
	cvtsi2sdl	%ebx, %xmm1
	movq	%rax, %xmm0
	movsd	%xmm1, 16(%rsp)
	call	pow@PLT
	movq	.LC1(%rip), %rax
	movsd	16(%rsp), %xmm1
	movsd	%xmm0, 8(%rsp)
	movq	%rax, %xmm0
	call	pow@PLT
	subsd	.LC2(%rip), %xmm0
	leal	-1(%rbx), %eax
	pxor	%xmm1, %xmm1
	mulsd	8(%rsp), %xmm0
	cvtsi2sdl	%eax, %xmm1
	mulsd	(%r12,%rbx,8), %xmm0
	movsd	%xmm0, 8(%rsp)
	movq	%r14, %xmm0
	call	pow@PLT
	mulsd	8(%rsp), %xmm0
	movsd	24(%rsp), %xmm2
	movq	%rbx, %rax
	movl	$1, %edx
	.p2align 4,,10
	.p2align 3
.L9:
	imulq	%rax, %rdx
	subq	$1, %rax
	cmpq	$1, %rax
	jne	.L9
	pxor	%xmm1, %xmm1
	addq	$2, %rbx
	cvtsi2sdq	%rdx, %xmm1
	divsd	%xmm1, %xmm0
	addsd	%xmm0, %xmm2
	cmpq	%rbp, %rbx
	jne	.L10
	addq	$40, %rsp
	.cfi_def_cfa_offset 40
	movapd	%xmm2, %xmm0
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L12:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 14
	pxor	%xmm2, %xmm2
	movapd	%xmm2, %xmm0
	ret
	.cfi_endproc
.LFE1:
	.size	th, .-th
	.p2align 4
	.globl	calculateTanh
	.type	calculateTanh, @function
calculateTanh:
.LFB2:
	.cfi_startproc
	endbr64
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movsd	%xmm0, (%rsp)
	call	exp@PLT
	movsd	(%rsp), %xmm2
	movsd	%xmm0, 24(%rsp)
	movapd	%xmm2, %xmm3
	xorpd	.LC3(%rip), %xmm3
	movsd	%xmm2, 8(%rsp)
	movapd	%xmm3, %xmm0
	movsd	%xmm3, 16(%rsp)
	call	exp@PLT
	movsd	8(%rsp), %xmm2
	movsd	%xmm0, (%rsp)
	movapd	%xmm2, %xmm0
	call	exp@PLT
	movsd	16(%rsp), %xmm3
	movsd	%xmm0, 8(%rsp)
	movapd	%xmm3, %xmm0
	call	exp@PLT
	movsd	24(%rsp), %xmm1
	subsd	(%rsp), %xmm1
	addsd	8(%rsp), %xmm0
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	divsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE2:
	.size	calculateTanh, .-calculateTanh
	.p2align 4
	.globl	power_series
	.type	power_series, @function
power_series:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pxor	%xmm3, %xmm3
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leaq	BERNOULLI(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	$2, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%r12, %r14
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	movq	.LC2(%rip), %rax
	movq	%rdi, 72(%rsp)
	movq	%rax, BERNOULLI(%rip)
	movq	.LC4(%rip), %rax
	movq	%rsi, 80(%rsp)
	movq	%rax, 8+BERNOULLI(%rip)
	movsd	%xmm0, 56(%rsp)
	movsd	%xmm1, 64(%rsp)
.L21:
	leaq	1(%r14), %rax
	movl	%r14d, 52(%rsp)
	movl	%r14d, %r8d
	xorl	%edi, %edi
	movq	%rax, 88(%rsp)
	andl	$1, %r8d
	movl	$1, %r9d
	movq	%r14, %rsi
	.p2align 4,,10
	.p2align 3
.L37:
	movl	%r9d, 48(%rsp)
	leaq	-1(%rdi), %r15
	leal	-2(%rdi), %eax
	movl	%edi, %r14d
	xorl	%r12d, %r12d
	subq	%rax, %r15
	.p2align 4,,10
	.p2align 3
.L35:
	movl	%r12d, %r10d
	movl	%r12d, %r11d
	movq	%rdi, %rax
	movl	$1, %ebp
	cmpq	$1, %rdi
	jbe	.L49
	.p2align 4,,10
	.p2align 3
.L25:
	imulq	%rax, %rbp
	subq	$1, %rax
	cmpq	%r15, %rax
	jne	.L25
.L24:
	cmpl	$1, %r14d
	jbe	.L50
	movq	%rdi, %rdx
	leal	-2(%r14), %eax
	movl	$1, %ebx
	subq	%r12, %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	.p2align 4,,10
	.p2align 3
.L28:
	movq	%rdx, %rax
	imulq	%rdx, %rbx
	subq	$1, %rdx
	cmpq	%rax, %rcx
	jne	.L28
.L22:
	cmpq	$1, %r12
	jbe	.L26
	leal	-2(%r10), %eax
	leaq	-1(%r12), %rcx
	movl	$1, %edx
	subq	%rax, %rcx
	movq	%r12, %rax
	.p2align 4,,10
	.p2align 3
.L31:
	imulq	%rax, %rdx
	subq	$1, %rax
	cmpq	%rax, %rcx
	jne	.L31
	imulq	%rdx, %rbx
.L26:
	movapd	%xmm3, %xmm0
	testl	%r8d, %r8d
	je	.L51
.L30:
	addq	$1, %r12
	movsd	%xmm0, 0(%r13,%rsi,8)
	subl	$1, %r14d
	cmpq	%r9, %r12
	jne	.L35
	leaq	1(%rdi), %rax
	addq	$1, %r9
	cmpq	%rsi, %rdi
	je	.L34
	movq	%rax, %rdi
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L51:
	pxor	%xmm4, %xmm4
	movq	.LC5(%rip), %rax
	movq	%rsi, 40(%rsp)
	cvtsi2sdl	%r11d, %xmm4
	movq	%r9, 32(%rsp)
	movq	%rax, %xmm0
	movq	%rdi, 24(%rsp)
	movl	%r8d, 16(%rsp)
	movapd	%xmm4, %xmm1
	movsd	%xmm4, 8(%rsp)
	call	pow@PLT
	pxor	%xmm1, %xmm1
	movsd	8(%rsp), %xmm4
	cvtsi2sdl	52(%rsp), %xmm1
	movsd	%xmm0, (%rsp)
	movapd	%xmm4, %xmm0
	call	pow@PLT
	movq	%rbp, %rax
	pxor	%xmm1, %xmm1
	pxor	%xmm3, %xmm3
	cqto
	movapd	%xmm0, %xmm2
	movsd	(%rsp), %xmm0
	movq	40(%rsp), %rsi
	idivq	%rbx
	movq	32(%rsp), %r9
	movq	24(%rsp), %rdi
	movl	16(%rsp), %r8d
	cvtsi2sdq	%rax, %xmm1
	mulsd	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdl	48(%rsp), %xmm1
	mulsd	%xmm2, %xmm0
	divsd	%xmm1, %xmm0
	addsd	0(%r13,%rsi,8), %xmm0
	jmp	.L30
	.p2align 4,,10
	.p2align 3
.L50:
	movl	$1, %ebx
	jmp	.L22
	.p2align 4,,10
	.p2align 3
.L49:
	movl	$1, %ebp
	jmp	.L24
.L34:
	movq	88(%rsp), %r14
	cmpq	$11, %r14
	jne	.L21
	movsd	56(%rsp), %xmm0
	call	exp@PLT
	movsd	56(%rsp), %xmm1
	xorpd	.LC3(%rip), %xmm1
	movq	%xmm0, %rbx
	movapd	%xmm1, %xmm0
	movsd	%xmm1, 16(%rsp)
	call	exp@PLT
	movsd	%xmm0, (%rsp)
	movsd	56(%rsp), %xmm0
	call	exp@PLT
	movsd	16(%rsp), %xmm1
	movsd	%xmm0, 8(%rsp)
	movapd	%xmm1, %xmm0
	call	exp@PLT
	movq	%rbx, %xmm5
	subsd	(%rsp), %xmm5
	movl	$1, %ebx
	movapd	%xmm0, %xmm1
	addsd	8(%rsp), %xmm1
	movapd	%xmm5, %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%rsp)
	jmp	.L38
.L52:
	cmpl	$11, %ebx
	je	.L20
.L38:
	movsd	56(%rsp), %xmm0
	movl	%ebx, %edi
	addl	$1, %ebx
	call	th
	movq	72(%rsp), %rax
	movsd	64(%rsp), %xmm1
	divsd	.LC7(%rip), %xmm1
	movsd	%xmm0, (%rax)
	subsd	(%rsp), %xmm0
	movq	80(%rsp), %rax
	andpd	.LC6(%rip), %xmm0
	comisd	%xmm1, %xmm0
	movsd	%xmm0, (%rax)
	ja	.L52
.L20:
	addq	$104, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
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
.LFE3:
	.size	power_series, .-power_series
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1073741824
	.align 8
.LC2:
	.long	0
	.long	1072693248
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC3:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC4:
	.long	0
	.long	-1075838976
	.align 8
.LC5:
	.long	0
	.long	-1074790400
	.section	.rodata.cst16
	.align 16
.LC6:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC7:
	.long	0
	.long	1079574528
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
