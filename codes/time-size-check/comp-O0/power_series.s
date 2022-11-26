	.file	"power_series.c"
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movl	%edi, -20(%rbp)
	cmpl	$0, -20(%rbp)
	je	.L2
	cmpl	$1, -20(%rbp)
	jne	.L3
.L2:
	movl	$1, %eax
	jmp	.L4
.L3:
	movl	-20(%rbp), %eax
	movslq	%eax, %rbx
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edi
	call	factorial
	imulq	%rbx, %rax
.L4:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -20(%rbp)
	movsd	%xmm0, -32(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
	movl	$1, -12(%rbp)
	jmp	.L6
.L7:
	movl	-12(%rbp), %eax
	addl	%eax, %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movq	.LC1(%rip), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movsd	%xmm0, -40(%rbp)
	movl	-12(%rbp), %eax
	addl	%eax, %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movq	.LC1(%rip), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movq	%xmm0, %rax
	movsd	.LC2(%rip), %xmm1
	movq	%rax, %xmm2
	subsd	%xmm1, %xmm2
	movapd	%xmm2, %xmm0
	movsd	-40(%rbp), %xmm1
	mulsd	%xmm0, %xmm1
	movl	-12(%rbp), %eax
	addl	%eax, %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	BERNOULLI(%rip), %rax
	movsd	(%rdx,%rax), %xmm0
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -40(%rbp)
	movl	-12(%rbp), %eax
	addl	%eax, %eax
	subl	$1, %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movq	-32(%rbp), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	mulsd	-40(%rbp), %xmm0
	movsd	%xmm0, -40(%rbp)
	movl	-12(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, %edi
	call	factorial
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movsd	-40(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	movsd	-8(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	addl	$1, -12(%rbp)
.L6:
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jle	.L7
	movsd	-8(%rbp), %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	leave
	.cfi_def_cfa 7, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movsd	%xmm0, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %xmm0
	call	exp@PLT
	movq	%xmm0, %rbx
	movsd	-40(%rbp), %xmm0
	movq	.LC3(%rip), %xmm1
	xorpd	%xmm1, %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	call	exp@PLT
	movq	%rbx, %xmm2
	subsd	%xmm0, %xmm2
	movsd	%xmm2, -48(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %xmm0
	call	exp@PLT
	movsd	%xmm0, -56(%rbp)
	movsd	-40(%rbp), %xmm0
	movq	.LC3(%rip), %xmm1
	movapd	%xmm0, %xmm3
	xorpd	%xmm1, %xmm3
	movq	%xmm3, %rax
	movq	%rax, %xmm0
	call	exp@PLT
	movsd	-56(%rbp), %xmm1
	addsd	%xmm0, %xmm1
	movsd	-48(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -24(%rbp)
	movsd	-24(%rbp), %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$96, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movsd	%xmm0, -72(%rbp)
	movsd	%xmm1, -80(%rbp)
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	movl	$10, -36(%rbp)
	movsd	.LC2(%rip), %xmm0
	movsd	%xmm0, BERNOULLI(%rip)
	movsd	.LC4(%rip), %xmm0
	movsd	%xmm0, 8+BERNOULLI(%rip)
	movl	$2, -52(%rbp)
	jmp	.L12
.L19:
	movl	$0, -48(%rbp)
	jmp	.L13
.L18:
	movl	$0, -44(%rbp)
	jmp	.L14
.L17:
	movl	-48(%rbp), %eax
	movl	%eax, %edi
	call	factorial
	movq	%rax, %rbx
	movl	-48(%rbp), %eax
	subl	-44(%rbp), %eax
	movl	%eax, %edi
	call	factorial
	movq	%rax, %r12
	movl	-44(%rbp), %eax
	movl	%eax, %edi
	call	factorial
	movq	%r12, %rdx
	imulq	%rax, %rdx
	movq	%rdx, %rcx
	movq	%rbx, %rax
	cqto
	idivq	%rcx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -24(%rbp)
	cmpl	$1, -52(%rbp)
	jle	.L15
	movl	-52(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	jne	.L15
	pxor	%xmm0, %xmm0
	cvtsi2sdl	-44(%rbp), %xmm0
	movq	.LC5(%rip), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	movq	%xmm0, %rax
	movq	%rax, %xmm3
	mulsd	-24(%rbp), %xmm3
	movsd	%xmm3, -104(%rbp)
	pxor	%xmm0, %xmm0
	cvtsi2sdl	-52(%rbp), %xmm0
	pxor	%xmm4, %xmm4
	cvtsi2sdl	-44(%rbp), %xmm4
	movq	%xmm4, %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %xmm0
	call	pow@PLT
	mulsd	-104(%rbp), %xmm0
	movl	-48(%rbp), %eax
	addl	$1, %eax
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%eax, %xmm2
	movapd	%xmm0, %xmm1
	divsd	%xmm2, %xmm1
	movl	-52(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	BERNOULLI(%rip), %rax
	movsd	(%rdx,%rax), %xmm0
	addsd	%xmm1, %xmm0
	movl	-52(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	BERNOULLI(%rip), %rax
	movsd	%xmm0, (%rdx,%rax)
	jmp	.L16
.L15:
	movl	-52(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	BERNOULLI(%rip), %rax
	pxor	%xmm0, %xmm0
	movsd	%xmm0, (%rdx,%rax)
.L16:
	addl	$1, -44(%rbp)
.L14:
	movl	-44(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jle	.L17
	addl	$1, -48(%rbp)
.L13:
	movl	-48(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jle	.L18
	addl	$1, -52(%rbp)
.L12:
	movl	-52(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jle	.L19
	movl	$1, -40(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %xmm0
	call	calculateTanh
	movq	%xmm0, %rax
	movq	%rax, -32(%rbp)
.L22:
	cmpl	$10, -40(%rbp)
	jg	.L23
	movq	-72(%rbp), %rdx
	movl	-40(%rbp), %eax
	movq	%rdx, %xmm0
	movl	%eax, %edi
	call	th
	movq	%xmm0, %rax
	movq	-88(%rbp), %rdx
	movq	%rax, (%rdx)
	movq	-88(%rbp), %rax
	movsd	(%rax), %xmm0
	subsd	-32(%rbp), %xmm0
	movq	.LC6(%rip), %xmm1
	andpd	%xmm1, %xmm0
	movq	-96(%rbp), %rax
	movsd	%xmm0, (%rax)
	addl	$1, -40(%rbp)
	movq	-96(%rbp), %rax
	movsd	(%rax), %xmm0
	movsd	-80(%rbp), %xmm1
	movsd	.LC7(%rip), %xmm2
	divsd	%xmm2, %xmm1
	comisd	%xmm1, %xmm0
	ja	.L22
	jmp	.L24
.L23:
	nop
.L24:
	nop
	addq	$96, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	power_series, .-power_series
	.section	.rodata
	.align 8
.LC1:
	.long	0
	.long	1073741824
	.align 8
.LC2:
	.long	0
	.long	1072693248
	.align 16
.LC3:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC4:
	.long	0
	.long	-1075838976
	.align 8
.LC5:
	.long	0
	.long	-1074790400
	.align 16
.LC6:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
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
