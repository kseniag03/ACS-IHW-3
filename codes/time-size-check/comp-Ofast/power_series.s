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
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	testl	%edi, %edi
	jle	.L12
	leal	1(%rdi), %ebx
	pxor	%xmm4, %xmm4
	movq	%xmm0, %r14
	movsd	.LC0(%rip), %xmm2
	addq	%rbx, %rbx
	movl	$2, %r12d
	movsd	%xmm4, (%rsp)
	leaq	BERNOULLI(%rip), %rbp
	.p2align 4,,10
	.p2align 3
.L10:
	leal	-1(%r12), %eax
	pxor	%xmm1, %xmm1
	movq	%r14, %xmm0
	movsd	%xmm2, 8(%rsp)
	cvtsi2sdl	%eax, %xmm1
	call	pow@PLT
	movsd	8(%rsp), %xmm2
	movq	%r12, %rax
	movl	$1, %edx
	mulsd	%xmm2, %xmm0
	movapd	%xmm2, %xmm1
	subsd	.LC2(%rip), %xmm1
	mulsd	0(%rbp,%r12,8), %xmm1
	mulsd	%xmm0, %xmm1
	.p2align 4,,10
	.p2align 3
.L9:
	imulq	%rax, %rdx
	subq	$1, %rax
	cmpq	$1, %rax
	jne	.L9
	pxor	%xmm0, %xmm0
	addq	$2, %r12
	cvtsi2sdq	%rdx, %xmm0
	divsd	%xmm0, %xmm1
	addsd	(%rsp), %xmm1
	movsd	%xmm1, (%rsp)
	cmpq	%r12, %rbx
	je	.L7
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%r12d, %xmm0
	call	exp2@PLT
	movapd	%xmm0, %xmm2
	jmp	.L10
.L12:
	pxor	%xmm5, %xmm5
	movsd	%xmm5, (%rsp)
.L7:
	movsd	(%rsp), %xmm0
	addq	$24, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movsd	%xmm0, 8(%rsp)
	call	exp@PLT
	movsd	8(%rsp), %xmm2
	xorpd	.LC3(%rip), %xmm2
	movsd	%xmm0, (%rsp)
	movapd	%xmm2, %xmm0
	call	exp@PLT
	movsd	(%rsp), %xmm1
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	movapd	%xmm0, %xmm2
	movapd	%xmm1, %xmm0
	addsd	%xmm2, %xmm1
	subsd	%xmm2, %xmm0
	divsd	%xmm1, %xmm0
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
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	16+BERNOULLI(%rip), %r14
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
	subq	$280, %rsp
	.cfi_def_cfa_offset 336
	movsd	%xmm0, 232(%rsp)
	movapd	.LC4(%rip), %xmm0
	movq	%rdi, 248(%rsp)
	movq	%rsi, 256(%rsp)
	movq	$2, 224(%rsp)
	movq	224(%rsp), %rax
	movsd	%xmm1, 240(%rsp)
	movups	%xmm0, BERNOULLI(%rip)
.L17:
	pxor	%xmm7, %xmm7
	leaq	1(%rax), %rbx
	movl	%eax, %r13d
	xorl	%r15d, %r15d
	cvtsi2sdl	%eax, %xmm7
	andl	$1, %r13d
	movq	%r15, %r12
	movq	%r14, %rbp
	movq	$-5, 192(%rsp)
	movq	$-4, 184(%rsp)
	movq	$-3, 176(%rsp)
	movq	$-2, 168(%rsp)
	movq	$-1, 160(%rsp)
	movq	%rbx, 264(%rsp)
	movsd	%xmm7, 72(%rsp)
	.p2align 4,,10
	.p2align 3
.L41:
	leal	1(%r12), %eax
	pxor	%xmm0, %xmm0
	testl	%r12d, %r12d
	movq	%r12, %rdx
	cvtsi2sdl	%eax, %xmm0
	movl	%eax, 64(%rsp)
	movq	160(%rsp), %rax
	movl	$1, %r14d
	cmovle	%r12d, %r14d
	movsd	.LC2(%rip), %xmm7
	xorl	%r15d, %r15d
	movq	168(%rsp), %rcx
	movl	%eax, %ebx
	movl	%r12d, 36(%rsp)
	imulq	%r12, %rax
	movl	%ecx, 8(%rsp)
	divsd	%xmm0, %xmm7
	movl	%r14d, 24(%rsp)
	movq	%r12, %r14
	movl	%r12d, 40(%rsp)
	movq	%rax, 136(%rsp)
	imulq	%rcx, %rax
	movq	176(%rsp), %rcx
	movl	%ebx, 56(%rsp)
	movq	%rbp, %rbx
	movl	%r12d, %ebp
	movl	%ecx, 16(%rsp)
	movq	%rax, 144(%rsp)
	imulq	%rcx, %rax
	movq	184(%rsp), %rcx
	movl	%ecx, 32(%rsp)
	movq	%rax, 152(%rsp)
	imulq	%rcx, %rax
	movq	%rax, %rcx
	movq	%rax, 200(%rsp)
	movq	192(%rsp), %rax
	imulq	%rax, %rcx
	movl	%eax, 44(%rsp)
	leal	-6(%r12), %eax
	movl	%eax, 68(%rsp)
	leaq	-6(%r12), %rax
	imulq	%rcx, %rax
	movq	%rcx, 208(%rsp)
	movq	%rax, 216(%rsp)
	movq	%rax, %rcx
	leal	-7(%r12), %eax
	movl	%eax, 128(%rsp)
	leaq	-7(%r12), %rax
	imulq	%rcx, %rax
	movq	%rax, %rcx
	movq	%rax, 112(%rsp)
	leal	-8(%r12), %eax
	movl	%eax, 132(%rsp)
	leaq	-8(%r12), %rax
	movl	%r15d, %r12d
	imulq	%rcx, %rax
	movsd	%xmm7, 48(%rsp)
	movq	%rax, 120(%rsp)
	cmpq	$1, %r14
	jbe	.L103
	.p2align 4,,10
	.p2align 3
.L97:
	cmpl	$1, 56(%rsp)
	jle	.L49
	cmpl	$1, 8(%rsp)
	jle	.L50
	cmpl	$1, 16(%rsp)
	jle	.L51
	cmpl	$1, 32(%rsp)
	jle	.L52
	cmpl	$1, 44(%rsp)
	jle	.L53
	cmpl	$1, 68(%rsp)
	jle	.L54
	cmpl	$1, 128(%rsp)
	jle	.L55
	movq	112(%rsp), %rax
	cmpl	$2, 132(%rsp)
	cmove	120(%rsp), %rax
.L35:
	cmpl	$1, %ebp
	jbe	.L104
.L95:
	leaq	-1(%rdx), %rdi
	leal	-2(%rbp), %r15d
	movq	%rdi, %r11
	subq	%r15, %r11
	movl	$1, %r15d
	.p2align 4,,10
	.p2align 3
.L23:
	imulq	%rdx, %r15
	subq	$1, %rdx
	cmpq	%r11, %rdx
	jne	.L23
	testl	%r13d, %r13d
	jne	.L105
.L21:
	pxor	%xmm2, %xmm2
	movq	%rax, 96(%rsp)
	movq	.LC5(%rip), %rax
	subl	$1, %ebp
	cvtsi2sdl	%r12d, %xmm2
	movq	%rdi, 104(%rsp)
	movq	%rax, %xmm0
	movapd	%xmm2, %xmm1
	movsd	%xmm2, 88(%rsp)
	call	pow@PLT
	movsd	88(%rsp), %xmm2
	movsd	72(%rsp), %xmm1
	movsd	%xmm0, 80(%rsp)
	movapd	%xmm2, %xmm0
	call	pow@PLT
	movq	96(%rsp), %rax
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	mulsd	80(%rsp), %xmm1
	cqto
	idivq	%r15
	movq	104(%rsp), %rdx
	leal	1(%r12), %r15d
	cvtsi2sdq	%rax, %xmm0
	mulsd	48(%rsp), %xmm0
	mulsd	%xmm1, %xmm0
	addsd	(%rbx), %xmm0
	movsd	%xmm0, (%rbx)
	cmpl	24(%rsp), %r15d
	jg	.L101
.L24:
	movl	$1, %r12d
	cmpq	$1, %r14
	ja	.L97
.L103:
	movl	$1, %eax
	cmpl	$1, %ebp
	ja	.L95
	.p2align 4,,10
	.p2align 3
.L104:
	movl	$1, %r15d
	leaq	-1(%rdx), %rdi
	testl	%r13d, %r13d
	je	.L21
	.p2align 4,,10
	.p2align 3
.L105:
	movq	$0x000000000, (%rbx)
	leal	1(%r12), %r15d
	subl	$1, %ebp
	movq	%rdi, %rdx
	cmpl	24(%rsp), %r15d
	jle	.L24
.L101:
	movl	36(%rsp), %eax
	movq	%rbx, %rbp
	movl	56(%rsp), %ebx
	movq	%r14, %r12
	movslq	%r15d, %r14
	leal	-2(%rax), %r9d
	movl	%ebx, %r8d
	cmpl	40(%rsp), %r15d
	jg	.L33
	.p2align 4,,10
	.p2align 3
.L34:
	cmpl	$1, 40(%rsp)
	je	.L57
.L107:
	cmpl	$1, %r8d
	jle	.L58
	cmpl	$1, 8(%rsp)
	jle	.L59
	cmpl	$1, 16(%rsp)
	jle	.L60
	cmpl	$1, 32(%rsp)
	jle	.L61
	cmpl	$1, 44(%rsp)
	jle	.L62
	cmpl	$1, 68(%rsp)
	jle	.L63
	cmpl	$1, 128(%rsp)
	jle	.L64
	movq	112(%rsp), %rax
	cmpl	$2, 132(%rsp)
	cmove	120(%rsp), %rax
.L26:
	movl	36(%rsp), %edx
	subl	%r15d, %edx
	cmpl	$1, %edx
	jbe	.L66
.L108:
	movq	%r12, %rsi
	movl	%r9d, %ecx
	subq	%r14, %rsi
	subl	%r15d, %ecx
	leaq	-1(%rsi), %rdx
	movq	%rdx, %rdi
	subq	%rcx, %rdi
	movl	$1, %ecx
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L106:
	subq	$1, %rdx
.L29:
	imulq	%rsi, %rcx
	movq	%rdx, %rsi
	cmpq	%rdx, %rdi
	jne	.L106
.L28:
	leal	-1(%r15), %esi
	movq	%r14, %rdx
	cmpl	$1, %esi
	jle	.L30
	leaq	-1(%r14), %rdx
	leal	-2(%r15), %esi
	imulq	%r14, %rdx
	cmpl	$3, %r15d
	je	.L30
	movslq	%esi, %rsi
	leal	-3(%r15), %edi
	imulq	%rsi, %rdx
	cmpl	$4, %r15d
	je	.L30
	movslq	%edi, %rdi
	leal	-4(%r15), %esi
	imulq	%rdi, %rdx
	cmpl	$5, %r15d
	je	.L30
	movslq	%esi, %rsi
	leal	-5(%r15), %edi
	imulq	%rsi, %rdx
	cmpl	$6, %r15d
	je	.L30
	movslq	%edi, %rdi
	leal	-6(%r15), %esi
	imulq	%rdi, %rdx
	cmpl	$7, %r15d
	je	.L30
	movslq	%esi, %rsi
	leal	-7(%r15), %edi
	imulq	%rsi, %rdx
	cmpl	$8, %r15d
	je	.L30
	movslq	%edi, %rdi
	leal	-8(%r15), %esi
	imulq	%rdi, %rdx
	cmpl	$9, %r15d
	je	.L30
	movslq	%esi, %rsi
	imulq	%rsi, %rdx
	cmpl	$10, %r15d
	leaq	(%rdx,%rdx), %rsi
	cmovne	%rsi, %rdx
.L30:
	movq	%rdx, %rbx
	movq	%rax, 24(%rsp)
	imulq	%rcx, %rbx
	testl	%r13d, %r13d
	jne	.L31
	pxor	%xmm2, %xmm2
	movq	.LC5(%rip), %rax
	movl	%r9d, 96(%rsp)
	addq	$1, %r14
	cvtsi2sdl	%r15d, %xmm2
	movl	%r8d, 88(%rsp)
	addl	$1, %r15d
	movq	%rax, %xmm0
	movapd	%xmm2, %xmm1
	movsd	%xmm2, 80(%rsp)
	call	pow@PLT
	movsd	80(%rsp), %xmm2
	movsd	72(%rsp), %xmm1
	movsd	%xmm0, 56(%rsp)
	movapd	%xmm2, %xmm0
	call	pow@PLT
	movq	24(%rsp), %rax
	movl	88(%rsp), %r8d
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	movl	96(%rsp), %r9d
	mulsd	56(%rsp), %xmm1
	cqto
	idivq	%rbx
	cmpl	64(%rsp), %r15d
	cvtsi2sdq	%rax, %xmm0
	mulsd	48(%rsp), %xmm0
	mulsd	%xmm1, %xmm0
	addsd	0(%rbp), %xmm0
	movsd	%xmm0, 0(%rbp)
	jne	.L34
.L33:
	addq	$1, 160(%rsp)
	leaq	1(%r12), %rax
	addq	$1, 168(%rsp)
	addq	$1, 176(%rsp)
	addq	$1, 184(%rsp)
	addq	$1, 192(%rsp)
	cmpq	224(%rsp), %r12
	je	.L38
	movq	%rax, %r12
	jmp	.L41
	.p2align 4,,10
	.p2align 3
.L31:
	movq	$0x000000000, 0(%rbp)
	addl	$1, %r15d
	addq	$1, %r14
	cmpl	64(%rsp), %r15d
	je	.L33
	cmpl	$1, 40(%rsp)
	jne	.L107
.L57:
	movl	36(%rsp), %edx
	movl	$1, %eax
	subl	%r15d, %edx
	cmpl	$1, %edx
	ja	.L108
	.p2align 4,,10
	.p2align 3
.L66:
	movl	$1, %ecx
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L49:
	movq	%r14, %rax
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L58:
	movq	%r12, %rax
	jmp	.L26
.L59:
	movq	136(%rsp), %rax
	jmp	.L26
.L50:
	movq	136(%rsp), %rax
	jmp	.L35
.L51:
	movq	144(%rsp), %rax
	jmp	.L35
.L60:
	movq	144(%rsp), %rax
	jmp	.L26
.L61:
	movq	152(%rsp), %rax
	jmp	.L26
.L52:
	movq	152(%rsp), %rax
	jmp	.L35
.L53:
	movq	200(%rsp), %rax
	jmp	.L35
.L62:
	movq	200(%rsp), %rax
	jmp	.L26
.L54:
	movq	208(%rsp), %rax
	jmp	.L35
.L63:
	movq	208(%rsp), %rax
	jmp	.L26
.L64:
	movq	216(%rsp), %rax
	jmp	.L26
.L55:
	movq	216(%rsp), %rax
	jmp	.L35
.L38:
	movq	264(%rsp), %rax
	movq	%rbp, %r14
	addq	$8, %r14
	cmpq	$11, %rax
	je	.L40
	movq	%rax, 224(%rsp)
	jmp	.L17
.L40:
	movsd	232(%rsp), %xmm0
	movl	$4, %ebx
	movl	$1, %r12d
	leaq	BERNOULLI(%rip), %rbp
	call	exp@PLT
	movsd	%xmm0, 8(%rsp)
	movsd	232(%rsp), %xmm0
	xorpd	.LC3(%rip), %xmm0
	call	exp@PLT
	movsd	8(%rsp), %xmm1
	movsd	240(%rsp), %xmm7
	mulsd	.LC6(%rip), %xmm7
	movapd	%xmm1, %xmm2
	addsd	%xmm0, %xmm1
	subsd	%xmm0, %xmm2
	divsd	%xmm1, %xmm2
	movq	%xmm7, %r13
	movsd	%xmm2, 24(%rsp)
.L46:
	movq	.LC0(%rip), %rax
	movl	$2, %r14d
	movq	$0x000000000, 8(%rsp)
	movq	%rax, %xmm2
.L44:
	leal	-1(%r14), %eax
	pxor	%xmm1, %xmm1
	movsd	%xmm2, 16(%rsp)
	movsd	232(%rsp), %xmm0
	cvtsi2sdl	%eax, %xmm1
	call	pow@PLT
	movsd	16(%rsp), %xmm2
	movq	%r14, %rax
	movl	$1, %edx
	movapd	%xmm0, %xmm1
	mulsd	%xmm2, %xmm1
	movapd	%xmm2, %xmm0
	subsd	.LC2(%rip), %xmm0
	mulsd	0(%rbp,%r14,8), %xmm0
	mulsd	%xmm1, %xmm0
	.p2align 4,,10
	.p2align 3
.L42:
	imulq	%rax, %rdx
	subq	$1, %rax
	cmpq	$1, %rax
	jne	.L42
	pxor	%xmm1, %xmm1
	addq	$2, %r14
	cvtsi2sdq	%rdx, %xmm1
	divsd	%xmm1, %xmm0
	addsd	8(%rsp), %xmm0
	movsd	%xmm0, 8(%rsp)
	cmpq	%r14, %rbx
	je	.L43
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%r14d, %xmm0
	call	exp2@PLT
	movapd	%xmm0, %xmm2
	jmp	.L44
.L43:
	movapd	%xmm0, %xmm7
	subsd	24(%rsp), %xmm7
	addl	$1, %r12d
	addq	$2, %rbx
	movq	248(%rsp), %rax
	movsd	%xmm0, (%rax)
	movapd	%xmm7, %xmm0
	andpd	.LC7(%rip), %xmm0
	movq	%r13, %xmm7
	movq	256(%rsp), %rax
	comisd	%xmm0, %xmm7
	movsd	%xmm0, (%rax)
	jnb	.L16
	cmpl	$11, %r12d
	jne	.L46
.L16:
	addq	$280, %rsp
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
.LC0:
	.long	0
	.long	1074790400
	.set	.LC2,.LC4
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC3:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 16
.LC4:
	.long	0
	.long	1072693248
	.long	0
	.long	-1075838976
	.section	.rodata.cst8
	.align 8
.LC5:
	.long	0
	.long	-1074790400
	.align 8
.LC6:
	.long	1202590843
	.long	1065646817
	.section	.rodata.cst16
	.align 16
.LC7:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
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
