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
.L21:
	movl	%eax, %r12d
	movl	%eax, 68(%rsp)
	addq	$1, %rax
	xorl	%r13d, %r13d
	movq	$-5, 176(%rsp)
	andl	$1, %r12d
	movq	$-4, 168(%rsp)
	movl	%r12d, %ecx
	movq	$-3, 160(%rsp)
	movq	$-2, 152(%rsp)
	movq	$-1, 144(%rsp)
	movq	%rax, 264(%rsp)
	.p2align 4,,10
	.p2align 3
.L45:
	testl	%r13d, %r13d
	movl	$1, %r10d
	leal	1(%r13), %r8d
	movq	%r13, %rdx
	cmovle	%r13d, %r10d
	movl	%r13d, 16(%rsp)
	movl	%r13d, %r15d
	movq	%r14, %rsi
	movq	144(%rsp), %rax
	movq	152(%rsp), %rbx
	movl	%r8d, 184(%rsp)
	movq	%r13, %r8
	movl	%r13d, 188(%rsp)
	movl	%r10d, %r12d
	movl	%eax, %edi
	imulq	%r13, %rax
	movl	%ebx, %r9d
	movq	%rax, 120(%rsp)
	imulq	%rbx, %rax
	movq	160(%rsp), %rbx
	movl	%ebx, (%rsp)
	movq	%rax, 128(%rsp)
	imulq	%rbx, %rax
	movq	168(%rsp), %rbx
	movl	%ebx, 8(%rsp)
	movq	%rax, 136(%rsp)
	imulq	%rbx, %rax
	movq	%rax, %rbx
	movq	%rax, 200(%rsp)
	movq	176(%rsp), %rax
	imulq	%rax, %rbx
	movl	%eax, 24(%rsp)
	leal	-6(%r13), %eax
	movl	%eax, 36(%rsp)
	leaq	-6(%r13), %rax
	imulq	%rbx, %rax
	movq	%rbx, 192(%rsp)
	movq	%rax, 208(%rsp)
	movq	%rax, %rbx
	leal	-7(%r13), %eax
	movl	%eax, 40(%rsp)
	leaq	-7(%r13), %rax
	imulq	%rbx, %rax
	movq	%rax, %rbx
	movq	%rax, 216(%rsp)
	leal	-8(%r13), %eax
	movl	%eax, 44(%rsp)
	leaq	-8(%r13), %rax
	imulq	%rbx, %rax
	movq	%rax, %rbx
	movq	%rax, 56(%rsp)
	leal	-9(%r13), %eax
	movl	%eax, 64(%rsp)
	leaq	-9(%r13), %rax
	movl	%ecx, %r13d
	imulq	%rbx, %rax
	xorl	%ebx, %ebx
	movq	%rax, 48(%rsp)
	cmpq	$1, %r8
	jbe	.L111
	.p2align 4,,10
	.p2align 3
.L104:
	cmpl	$1, %edi
	jle	.L53
	cmpl	$1, %r9d
	jle	.L54
	cmpl	$1, (%rsp)
	jle	.L55
	cmpl	$1, 8(%rsp)
	jle	.L56
	cmpl	$1, 24(%rsp)
	jle	.L57
	cmpl	$1, 36(%rsp)
	jle	.L58
	cmpl	$1, 40(%rsp)
	jle	.L59
	cmpl	$1, 44(%rsp)
	jle	.L60
	movq	48(%rsp), %rax
	cmpl	$2, 64(%rsp)
	cmovne	56(%rsp), %rax
.L39:
	cmpl	$1, %r15d
	jbe	.L112
.L102:
	leaq	-1(%rdx), %r14
	leal	-2(%r15), %ebp
	movq	%r14, %r11
	subq	%rbp, %r11
	movl	$1, %ebp
	.p2align 4,,10
	.p2align 3
.L27:
	imulq	%rdx, %rbp
	subq	$1, %rdx
	cmpq	%r11, %rdx
	jne	.L27
	testl	%r13d, %r13d
	je	.L113
.L103:
	addl	$1, %ebx
	movq	$0x000000000, (%rsi)
	subl	$1, %r15d
	movq	%r14, %rdx
	cmpl	%ebx, %r12d
	jl	.L109
.L28:
	movl	$1, %ebx
	cmpq	$1, %r8
	ja	.L104
.L111:
	movl	$1, %eax
	cmpl	$1, %r15d
	ja	.L102
	.p2align 4,,10
	.p2align 3
.L112:
	movl	$1, %ebp
	leaq	-1(%rdx), %r14
	testl	%r13d, %r13d
	jne	.L103
	.p2align 4,,10
	.p2align 3
.L113:
	pxor	%xmm2, %xmm2
	movq	%rax, 88(%rsp)
	movq	.LC5(%rip), %rax
	subl	$1, %r15d
	cvtsi2sdl	%ebx, %xmm2
	movq	%rsi, 112(%rsp)
	addl	$1, %ebx
	movq	%rax, %xmm0
	movl	%r9d, 108(%rsp)
	movl	%edi, 104(%rsp)
	movq	%r8, 96(%rsp)
	movapd	%xmm2, %xmm1
	movsd	%xmm2, 80(%rsp)
	call	pow@PLT
	pxor	%xmm1, %xmm1
	movsd	80(%rsp), %xmm2
	cvtsi2sdl	68(%rsp), %xmm1
	movsd	%xmm0, 72(%rsp)
	movapd	%xmm2, %xmm0
	call	pow@PLT
	movq	88(%rsp), %rax
	movq	112(%rsp), %rsi
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	movq	96(%rsp), %r8
	movl	104(%rsp), %edi
	cqto
	movl	108(%rsp), %r9d
	idivq	%rbp
	cmpl	%ebx, %r12d
	movq	%r14, %rdx
	cvtsi2sdq	%rax, %xmm0
	mulsd	72(%rsp), %xmm0
	mulsd	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdl	184(%rsp), %xmm1
	divsd	%xmm1, %xmm0
	addsd	(%rsi), %xmm0
	movsd	%xmm0, (%rsi)
	jge	.L28
.L109:
	movl	%r13d, %ecx
	movq	%rsi, %r14
	movq	%r8, %r13
	movl	188(%rsp), %esi
	movl	184(%rsp), %r8d
	movslq	%ebx, %rbp
	movl	%esi, %r12d
	movl	%r8d, %r15d
	cmpl	16(%rsp), %ebx
	jg	.L37
	.p2align 4,,10
	.p2align 3
.L38:
	cmpl	$1, 16(%rsp)
	je	.L62
.L116:
	cmpl	$1, %edi
	jle	.L63
	cmpl	$1, %r9d
	jle	.L64
	cmpl	$1, (%rsp)
	jle	.L65
	cmpl	$1, 8(%rsp)
	jle	.L66
	cmpl	$1, 24(%rsp)
	jle	.L67
	cmpl	$1, 36(%rsp)
	jle	.L68
	cmpl	$1, 40(%rsp)
	jle	.L69
	cmpl	$1, 44(%rsp)
	jle	.L70
	movq	56(%rsp), %rax
	cmpl	$2, 64(%rsp)
	cmove	48(%rsp), %rax
.L30:
	movl	%r12d, %edx
	subl	%ebx, %edx
	cmpl	$1, %edx
	jbe	.L72
.L117:
	movq	%r13, %r11
	leal	-2(%r12), %r8d
	movl	$1, %r10d
	subq	%rbp, %r11
	subl	%ebx, %r8d
	leaq	-1(%r11), %rdx
	movq	%rdx, %rsi
	subq	%r8, %rsi
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L114:
	subq	$1, %rdx
.L33:
	imulq	%r11, %r10
	movq	%rdx, %r11
	cmpq	%rsi, %rdx
	jne	.L114
.L32:
	leal	-1(%rbx), %esi
	movq	%rbp, %rdx
	cmpl	$1, %esi
	jle	.L34
	leaq	-1(%rbp), %rdx
	leal	-2(%rbx), %esi
	imulq	%rbp, %rdx
	cmpl	$3, %ebx
	je	.L34
	movslq	%esi, %rsi
	leal	-3(%rbx), %r8d
	imulq	%rsi, %rdx
	cmpl	$4, %ebx
	je	.L34
	movslq	%r8d, %r8
	leal	-4(%rbx), %esi
	imulq	%r8, %rdx
	cmpl	$5, %ebx
	je	.L34
	movslq	%esi, %rsi
	leal	-5(%rbx), %r8d
	imulq	%rsi, %rdx
	cmpl	$6, %ebx
	je	.L34
	movslq	%r8d, %r8
	leal	-6(%rbx), %esi
	imulq	%r8, %rdx
	cmpl	$7, %ebx
	je	.L34
	movslq	%esi, %rsi
	leal	-7(%rbx), %r8d
	imulq	%rsi, %rdx
	cmpl	$8, %ebx
	je	.L34
	movslq	%r8d, %r8
	leal	-8(%rbx), %esi
	imulq	%r8, %rdx
	cmpl	$9, %ebx
	je	.L34
	movslq	%esi, %rsi
	imulq	%rsi, %rdx
	cmpl	$10, %ebx
	leaq	(%rdx,%rdx), %rsi
	cmovne	%rsi, %rdx
.L34:
	movq	%rdx, %rsi
	imulq	%r10, %rsi
	testl	%ecx, %ecx
	je	.L115
	addl	$1, %ebx
	movq	$0x000000000, (%r14)
	addq	$1, %rbp
	cmpl	%r15d, %ebx
	jne	.L38
.L37:
	addq	$1, 144(%rsp)
	leaq	1(%r13), %rax
	addq	$1, 152(%rsp)
	addq	$1, 160(%rsp)
	addq	$1, 168(%rsp)
	addq	$1, 176(%rsp)
	cmpq	224(%rsp), %r13
	je	.L42
	movq	%rax, %r13
	jmp	.L45
	.p2align 4,,10
	.p2align 3
.L115:
	pxor	%xmm2, %xmm2
	movq	%rax, 96(%rsp)
	movq	.LC5(%rip), %rax
	addq	$1, %rbp
	cvtsi2sdl	%ebx, %xmm2
	movl	%r9d, 112(%rsp)
	addl	$1, %ebx
	movq	%rax, %xmm0
	movl	%edi, 108(%rsp)
	movl	%ecx, 104(%rsp)
	movq	%rsi, 88(%rsp)
	movapd	%xmm2, %xmm1
	movsd	%xmm2, 80(%rsp)
	call	pow@PLT
	pxor	%xmm1, %xmm1
	movsd	80(%rsp), %xmm2
	cvtsi2sdl	68(%rsp), %xmm1
	movsd	%xmm0, 72(%rsp)
	movapd	%xmm2, %xmm0
	call	pow@PLT
	movq	96(%rsp), %rax
	movq	88(%rsp), %rsi
	movapd	%xmm0, %xmm1
	pxor	%xmm0, %xmm0
	movl	104(%rsp), %ecx
	movl	108(%rsp), %edi
	cqto
	movl	112(%rsp), %r9d
	idivq	%rsi
	cmpl	%r15d, %ebx
	cvtsi2sdq	%rax, %xmm0
	mulsd	72(%rsp), %xmm0
	mulsd	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%r15d, %xmm1
	divsd	%xmm1, %xmm0
	addsd	(%r14), %xmm0
	movsd	%xmm0, (%r14)
	je	.L37
	cmpl	$1, 16(%rsp)
	jne	.L116
.L62:
	movl	%r12d, %edx
	movl	$1, %eax
	subl	%ebx, %edx
	cmpl	$1, %edx
	ja	.L117
	.p2align 4,,10
	.p2align 3
.L72:
	movl	$1, %r10d
	jmp	.L32
	.p2align 4,,10
	.p2align 3
.L53:
	movq	%r8, %rax
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L63:
	movq	%r13, %rax
	jmp	.L30
.L64:
	movq	120(%rsp), %rax
	jmp	.L30
.L54:
	movq	120(%rsp), %rax
	jmp	.L39
.L55:
	movq	128(%rsp), %rax
	jmp	.L39
.L65:
	movq	128(%rsp), %rax
	jmp	.L30
.L66:
	movq	136(%rsp), %rax
	jmp	.L30
.L56:
	movq	136(%rsp), %rax
	jmp	.L39
.L57:
	movq	200(%rsp), %rax
	jmp	.L39
.L67:
	movq	200(%rsp), %rax
	jmp	.L30
.L68:
	movq	192(%rsp), %rax
	jmp	.L30
.L58:
	movq	192(%rsp), %rax
	jmp	.L39
.L59:
	movq	208(%rsp), %rax
	jmp	.L39
.L69:
	movq	208(%rsp), %rax
	jmp	.L30
.L70:
	movq	216(%rsp), %rax
	jmp	.L30
.L60:
	movq	216(%rsp), %rax
	jmp	.L39
.L42:
	movq	264(%rsp), %rax
	addq	$8, %r14
	cmpq	$11, %rax
	je	.L44
	movq	%rax, 224(%rsp)
	jmp	.L21
.L44:
	movsd	232(%rsp), %xmm0
	movl	$1, %r12d
	leaq	BERNOULLI(%rip), %rbp
	call	exp@PLT
	movsd	232(%rsp), %xmm1
	xorpd	.LC3(%rip), %xmm1
	movq	%xmm0, %rbx
	movapd	%xmm1, %xmm0
	movsd	%xmm1, 16(%rsp)
	call	exp@PLT
	movsd	%xmm0, (%rsp)
	movsd	232(%rsp), %xmm0
	call	exp@PLT
	movsd	16(%rsp), %xmm1
	movsd	%xmm0, 8(%rsp)
	movapd	%xmm1, %xmm0
	call	exp@PLT
	movq	%rbx, %xmm7
	subsd	(%rsp), %xmm7
	movl	$4, %ebx
	movapd	%xmm0, %xmm1
	addsd	8(%rsp), %xmm1
	movapd	%xmm7, %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, 24(%rsp)
.L50:
	movl	$2, %r13d
	pxor	%xmm2, %xmm2
.L47:
	pxor	%xmm1, %xmm1
	movq	.LC1(%rip), %rax
	movsd	%xmm2, 16(%rsp)
	cvtsi2sdl	%r13d, %xmm1
	movq	%rax, %xmm0
	movsd	%xmm1, 8(%rsp)
	call	pow@PLT
	movq	.LC1(%rip), %rax
	movsd	8(%rsp), %xmm1
	movsd	%xmm0, (%rsp)
	movq	%rax, %xmm0
	call	pow@PLT
	leal	-1(%r13), %eax
	pxor	%xmm1, %xmm1
	subsd	.LC2(%rip), %xmm0
	mulsd	(%rsp), %xmm0
	cvtsi2sdl	%eax, %xmm1
	mulsd	0(%rbp,%r13,8), %xmm0
	movsd	%xmm0, (%rsp)
	movsd	232(%rsp), %xmm0
	call	pow@PLT
	mulsd	(%rsp), %xmm0
	movsd	16(%rsp), %xmm2
	movq	%r13, %rax
	movl	$1, %edx
	.p2align 4,,10
	.p2align 3
.L46:
	imulq	%rax, %rdx
	subq	$1, %rax
	cmpq	$1, %rax
	jne	.L46
	pxor	%xmm1, %xmm1
	addq	$2, %r13
	cvtsi2sdq	%rdx, %xmm1
	divsd	%xmm1, %xmm0
	addsd	%xmm0, %xmm2
	cmpq	%r13, %rbx
	jne	.L47
	movq	248(%rsp), %rax
	addl	$1, %r12d
	addq	$2, %rbx
	movsd	240(%rsp), %xmm0
	divsd	.LC7(%rip), %xmm0
	movsd	%xmm2, (%rax)
	subsd	24(%rsp), %xmm2
	andpd	.LC6(%rip), %xmm2
	movq	256(%rsp), %rax
	comisd	%xmm0, %xmm2
	movsd	%xmm2, (%rax)
	jbe	.L20
	cmpl	$11, %r12d
	jne	.L50
.L20:
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
.LC1:
	.long	0
	.long	1073741824
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
