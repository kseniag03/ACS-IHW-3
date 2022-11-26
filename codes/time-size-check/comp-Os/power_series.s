	.file	"power_series.c"
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	endbr64
	movslq	%edi, %rdx
	movl	$1, %eax
.L3:
	cmpl	$1, %edi
	jbe	.L4
	imulq	%rdx, %rax
	decl	%edi
	decq	%rdx
	jmp	.L3
.L4:
	ret
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.globl	th
	.type	th, @function
th:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	xorps	%xmm2, %xmm2
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	$1, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%xmm0, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	leaq	BERNOULLI(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movl	%edi, %ebx
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
.L7:
	addq	$16, %rbp
	cmpl	%ebx, %r13d
	jg	.L10
	leal	(%r13,%r13), %r14d
	movq	.LC1(%rip), %rax
	movsd	%xmm2, 24(%rsp)
	incl	%r13d
	cvtsi2sdl	%r14d, %xmm1
	movq	%rax, %xmm0
	movsd	%xmm1, 16(%rsp)
	call	pow@PLT
	movq	.LC1(%rip), %rax
	movsd	16(%rsp), %xmm1
	movsd	%xmm0, 8(%rsp)
	movq	%rax, %xmm0
	call	pow@PLT
	subsd	.LC2(%rip), %xmm0
	mulsd	8(%rsp), %xmm0
	leal	-1(%r14), %eax
	mulsd	0(%rbp), %xmm0
	cvtsi2sdl	%eax, %xmm1
	movsd	%xmm0, 8(%rsp)
	movq	%r12, %xmm0
	call	pow@PLT
	mulsd	8(%rsp), %xmm0
	movl	%r14d, %edi
	call	factorial
	movsd	24(%rsp), %xmm2
	cvtsi2sdq	%rax, %xmm1
	divsd	%xmm1, %xmm0
	addsd	%xmm0, %xmm2
	jmp	.L7
.L10:
	addq	$32, %rsp
	.cfi_def_cfa_offset 48
	movaps	%xmm2, %xmm0
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1:
	.size	th, .-th
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
	movaps	%xmm2, %xmm3
	xorps	.LC3(%rip), %xmm3
	movsd	%xmm2, 8(%rsp)
	movaps	%xmm3, %xmm0
	movsd	%xmm3, 16(%rsp)
	call	exp@PLT
	movsd	8(%rsp), %xmm2
	movsd	%xmm0, (%rsp)
	movaps	%xmm2, %xmm0
	call	exp@PLT
	movsd	16(%rsp), %xmm3
	movsd	%xmm0, 8(%rsp)
	movaps	%xmm3, %xmm0
	call	exp@PLT
	movsd	24(%rsp), %xmm1
	subsd	(%rsp), %xmm1
	addsd	8(%rsp), %xmm0
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	divsd	%xmm0, %xmm1
	movaps	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE2:
	.size	calculateTanh, .-calculateTanh
	.globl	power_series
	.type	power_series, @function
power_series:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	BERNOULLI(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movl	$2, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%xmm0, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	.LC2(%rip), %rax
	movq	%rdi, 48(%rsp)
	movq	%rax, BERNOULLI(%rip)
	movq	.LC4(%rip), %rax
	movq	%rsi, 56(%rsp)
	movq	%rax, 8+BERNOULLI(%rip)
	movsd	%xmm1, 40(%rsp)
.L14:
	movl	%r13d, 72(%rsp)
	movl	%r13d, %r15d
	xorl	%ebx, %ebx
.L19:
	movl	%ebx, %edi
	xorl	%ebp, %ebp
	call	factorial
	movq	%rax, 8(%rsp)
.L16:
	leal	1(%rbx), %r8d
	xorps	%xmm0, %xmm0
	testb	$1, 72(%rsp)
	jne	.L15
	cvtsi2sdl	%ebp, %xmm2
	movsd	.LC5(%rip), %xmm0
	movl	%r8d, 76(%rsp)
	movaps	%xmm2, %xmm1
	movsd	%xmm2, 64(%rsp)
	call	pow@PLT
	movl	%ebp, %edi
	cvtsi2sdl	%r15d, %xmm1
	movsd	%xmm0, 32(%rsp)
	call	factorial
	movl	%ebx, %edi
	subl	%ebp, %edi
	movq	%rax, 24(%rsp)
	call	factorial
	movsd	64(%rsp), %xmm2
	movq	%rax, 16(%rsp)
	movaps	%xmm2, %xmm0
	call	pow@PLT
	movq	8(%rsp), %rax
	movq	16(%rsp), %rsi
	imulq	24(%rsp), %rsi
	movaps	%xmm0, %xmm1
	movl	76(%rsp), %r8d
	cqto
	idivq	%rsi
	cvtsi2sdq	%rax, %xmm0
	mulsd	32(%rsp), %xmm0
	mulsd	%xmm1, %xmm0
	cvtsi2sdl	%r8d, %xmm1
	divsd	%xmm1, %xmm0
	addsd	(%r14,%r13,8), %xmm0
.L15:
	incl	%ebp
	movsd	%xmm0, (%r14,%r13,8)
	cmpl	%ebx, %ebp
	jle	.L16
	incl	%ebx
	cmpl	%r13d, %ebx
	jle	.L19
	incq	%r13
	cmpq	$11, %r13
	jne	.L14
	movq	%r12, %xmm0
	movl	$1, %ebx
	call	calculateTanh
	movsd	%xmm0, 8(%rsp)
.L20:
	movl	%ebx, %edi
	movq	%r12, %xmm0
	incl	%ebx
	call	th
	movq	48(%rsp), %rax
	movsd	40(%rsp), %xmm1
	divsd	.LC7(%rip), %xmm1
	movsd	%xmm0, (%rax)
	subsd	8(%rsp), %xmm0
	movq	56(%rsp), %rax
	andps	.LC6(%rip), %xmm0
	comisd	%xmm1, %xmm0
	movsd	%xmm0, (%rax)
	jbe	.L13
	cmpl	$11, %ebx
	jne	.L20
.L13:
	addq	$88, %rsp
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
