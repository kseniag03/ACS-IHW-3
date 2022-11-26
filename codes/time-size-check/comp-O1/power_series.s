	.file	"power_series.c"
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	endbr64
	movl	$1, %eax
	cmpl	$1, %edi
	jbe	.L5
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%edi, %ebx
	leal	-1(%rdi), %edi
	call	factorial
	movq	%rax, %rdx
	movslq	%ebx, %rax
	imulq	%rdx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore 3
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
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	testl	%edi, %edi
	jle	.L11
	movl	%edi, %r13d
	movq	%xmm0, %r14
	leaq	16+BERNOULLI(%rip), %r12
	movl	$1, %ebx
	pxor	%xmm6, %xmm6
	movsd	%xmm6, (%rsp)
.L10:
	leal	(%rbx,%rbx), %ebp
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%ebp, %xmm2
	movq	%xmm2, %r15
	movapd	%xmm2, %xmm1
	movq	.LC1(%rip), %rax
	movq	%rax, %xmm0
	call	pow@PLT
	movsd	%xmm0, 8(%rsp)
	movq	%r15, %xmm1
	movq	.LC1(%rip), %rax
	movq	%rax, %xmm0
	call	pow@PLT
	subsd	.LC2(%rip), %xmm0
	mulsd	8(%rsp), %xmm0
	mulsd	(%r12), %xmm0
	movsd	%xmm0, 8(%rsp)
	leal	-1(%rbp), %eax
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	movq	%r14, %xmm0
	call	pow@PLT
	mulsd	8(%rsp), %xmm0
	movsd	%xmm0, 8(%rsp)
	movl	%ebp, %edi
	call	factorial
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movsd	8(%rsp), %xmm0
	divsd	%xmm1, %xmm0
	addsd	(%rsp), %xmm0
	movsd	%xmm0, (%rsp)
	addl	$1, %ebx
	addq	$16, %r12
	cmpl	%ebx, %r13d
	jge	.L10
.L8:
	movsd	(%rsp), %xmm0
	addq	$24, %rsp
	.cfi_remember_state
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
.L11:
	.cfi_restore_state
	pxor	%xmm7, %xmm7
	movsd	%xmm7, (%rsp)
	jmp	.L8
	.cfi_endproc
.LFE1:
	.size	th, .-th
	.globl	calculateTanh
	.type	calculateTanh, @function
calculateTanh:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movq	%xmm0, %rbp
	call	exp@PLT
	movq	%xmm0, %rbx
	movq	%rbp, %xmm2
	xorpd	.LC3(%rip), %xmm2
	movq	%xmm2, %r14
	movapd	%xmm2, %xmm0
	call	exp@PLT
	movq	%xmm0, %r15
	movq	%rbp, %xmm0
	call	exp@PLT
	movq	%xmm0, %rbp
	movq	%r14, %xmm0
	call	exp@PLT
	movapd	%xmm0, %xmm1
	movq	%rbx, %xmm0
	movq	%r15, %xmm3
	subsd	%xmm3, %xmm0
	movq	%rbp, %xmm4
	addsd	%xmm4, %xmm1
	divsd	%xmm1, %xmm0
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
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
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movsd	%xmm0, 48(%rsp)
	movsd	%xmm1, 56(%rsp)
	movq	%rdi, 64(%rsp)
	movq	%rsi, 72(%rsp)
	movq	.LC2(%rip), %rax
	movq	%rax, BERNOULLI(%rip)
	movq	.LC4(%rip), %rax
	movq	%rax, 8+BERNOULLI(%rip)
	leaq	16+BERNOULLI(%rip), %r15
	movl	$2, %r13d
	movl	%r13d, %ebx
	movq	%r15, %r14
	jmp	.L17
.L27:
	pxor	%xmm0, %xmm0
.L18:
	movsd	%xmm0, (%r14)
	addl	$1, %ebp
	cmpl	%r12d, %ebp
	jg	.L21
.L19:
	movl	%r12d, %edi
	call	factorial
	movq	%rax, 8(%rsp)
	movl	%r12d, 28(%rsp)
	movl	%r12d, %edi
	subl	%ebp, %edi
	call	factorial
	movq	%rax, 16(%rsp)
	movl	%ebp, %edi
	call	factorial
	movq	%rax, %r15
	cmpl	$1, %ebx
	jle	.L27
	pxor	%xmm0, %xmm0
	testl	%r13d, %r13d
	jne	.L18
	pxor	%xmm3, %xmm3
	cvtsi2sdl	%ebp, %xmm3
	movsd	%xmm3, 32(%rsp)
	movapd	%xmm3, %xmm1
	movsd	.LC5(%rip), %xmm0
	call	pow@PLT
	movsd	%xmm0, 40(%rsp)
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%ebx, %xmm1
	movsd	32(%rsp), %xmm0
	call	pow@PLT
	movapd	%xmm0, %xmm2
	movq	16(%rsp), %rcx
	imulq	%r15, %rcx
	movq	8(%rsp), %rax
	cqto
	idivq	%rcx
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movsd	40(%rsp), %xmm0
	mulsd	%xmm1, %xmm0
	mulsd	%xmm2, %xmm0
	movl	28(%rsp), %eax
	addl	$1, %eax
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	divsd	%xmm1, %xmm0
	addsd	(%r14), %xmm0
	jmp	.L18
.L21:
	addl	$1, %r12d
	cmpl	%ebx, %r12d
	jg	.L20
.L23:
	movl	$0, %ebp
	movl	%ebx, %r15d
	andl	$1, %r15d
	movl	%r15d, %r13d
	testl	%r12d, %r12d
	jns	.L19
	jmp	.L21
.L20:
	addl	$1, %ebx
	addq	$8, %r14
	cmpl	$11, %ebx
	je	.L22
.L17:
	movl	$0, %r12d
	testl	%ebx, %ebx
	jns	.L23
	jmp	.L20
.L22:
	movsd	48(%rsp), %xmm0
	call	calculateTanh
	movsd	%xmm0, 8(%rsp)
	movl	$1, %ebx
	movq	64(%rsp), %rbp
	movq	72(%rsp), %r12
.L24:
	movsd	48(%rsp), %xmm0
	movl	%ebx, %edi
	call	th
	movsd	%xmm0, 0(%rbp)
	subsd	8(%rsp), %xmm0
	andpd	.LC6(%rip), %xmm0
	movsd	%xmm0, (%r12)
	addl	$1, %ebx
	movsd	56(%rsp), %xmm1
	divsd	.LC7(%rip), %xmm1
	comisd	%xmm1, %xmm0
	jbe	.L16
	cmpl	$11, %ebx
	jne	.L24
.L16:
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
