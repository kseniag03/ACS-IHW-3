	.file	"power_series.c"
	.intel_syntax noprefix
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 24
	mov	DWORD PTR -20[rbp], edi
	cmp	DWORD PTR -20[rbp], 0
	je	.L2
	cmp	DWORD PTR -20[rbp], 1
	jne	.L3
.L2:
	mov	eax, 1
	jmp	.L4
.L3:
	mov	eax, DWORD PTR -20[rbp]
	movsx	rbx, eax
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	mov	edi, eax
	call	factorial
	imul	rax, rbx
.L4:
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	factorial, .-factorial
	.globl	th
	.type	th, @function
th:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR -20[rbp], edi
	movsd	QWORD PTR -32[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0
	mov	DWORD PTR -12[rbp], 1
	jmp	.L6
.L7:
	mov	eax, DWORD PTR -12[rbp]
	add	eax, eax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mov	rax, QWORD PTR .LC1[rip]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movsd	QWORD PTR -40[rbp], xmm0
	mov	eax, DWORD PTR -12[rbp]
	add	eax, eax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mov	rax, QWORD PTR .LC1[rip]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movq	rax, xmm0
	movsd	xmm1, QWORD PTR .LC2[rip]
	movq	xmm2, rax
	subsd	xmm2, xmm1
	movapd	xmm0, xmm2
	movsd	xmm1, QWORD PTR -40[rbp]
	mulsd	xmm1, xmm0
	mov	eax, DWORD PTR -12[rbp]
	add	eax, eax
	cdqe
	lea	rdx, 0[0+rax*8]
	lea	rax, BERNOULLI[rip]
	movsd	xmm0, QWORD PTR [rdx+rax]
	mulsd	xmm1, xmm0
	movsd	QWORD PTR -40[rbp], xmm1
	mov	eax, DWORD PTR -12[rbp]
	add	eax, eax
	sub	eax, 1
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mov	rax, QWORD PTR -32[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	mulsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -40[rbp], xmm0
	mov	eax, DWORD PTR -12[rbp]
	add	eax, eax
	mov	edi, eax
	call	factorial
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, rax
	movsd	xmm0, QWORD PTR -40[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -8[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	add	DWORD PTR -12[rbp], 1
.L6:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jle	.L7
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	th, .-th
	.globl	calculateTanh
	.type	calculateTanh, @function
calculateTanh:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 56
	movsd	QWORD PTR -40[rbp], xmm0
	mov	rax, QWORD PTR -40[rbp]
	movq	xmm0, rax
	call	exp@PLT
	movq	rbx, xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	movq	xmm1, QWORD PTR .LC3[rip]
	xorpd	xmm0, xmm1
	movq	rax, xmm0
	movq	xmm0, rax
	call	exp@PLT
	movq	xmm2, rbx
	subsd	xmm2, xmm0
	movsd	QWORD PTR -48[rbp], xmm2
	mov	rax, QWORD PTR -40[rbp]
	movq	xmm0, rax
	call	exp@PLT
	movsd	QWORD PTR -56[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	movq	xmm1, QWORD PTR .LC3[rip]
	movapd	xmm3, xmm0
	xorpd	xmm3, xmm1
	movq	rax, xmm3
	movq	xmm0, rax
	call	exp@PLT
	movsd	xmm1, QWORD PTR -56[rbp]
	addsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -48[rbp]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	movsd	xmm0, QWORD PTR -24[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	calculateTanh, .-calculateTanh
	.globl	power_series
	.type	power_series, @function
power_series:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r12
	push	rbx
	sub	rsp, 96
	movsd	QWORD PTR -72[rbp], xmm0
	movsd	QWORD PTR -80[rbp], xmm1
	mov	QWORD PTR -88[rbp], rdi
	mov	QWORD PTR -96[rbp], rsi
	mov	DWORD PTR -36[rbp], 10
	movsd	xmm0, QWORD PTR .LC2[rip]
	movsd	QWORD PTR BERNOULLI[rip], xmm0
	movsd	xmm0, QWORD PTR .LC4[rip]
	movsd	QWORD PTR BERNOULLI[rip+8], xmm0
	mov	DWORD PTR -20[rbp], 2
	jmp	.L12
.L19:
	mov	DWORD PTR -24[rbp], 0
	jmp	.L13
.L18:
	mov	DWORD PTR -28[rbp], 0
	jmp	.L14
.L17:
	mov	eax, DWORD PTR -24[rbp]
	mov	edi, eax
	call	factorial
	mov	rbx, rax
	mov	eax, DWORD PTR -24[rbp]
	sub	eax, DWORD PTR -28[rbp]
	mov	edi, eax
	call	factorial
	mov	r12, rax
	mov	eax, DWORD PTR -28[rbp]
	mov	edi, eax
	call	factorial
	mov	rdx, r12
	imul	rdx, rax
	mov	rcx, rdx
	mov	rax, rbx
	cqo
	idiv	rcx
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	movsd	QWORD PTR -56[rbp], xmm0
	cmp	DWORD PTR -20[rbp], 1
	jle	.L15
	mov	eax, DWORD PTR -20[rbp]
	and	eax, 1
	test	eax, eax
	jne	.L15
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -28[rbp]
	mov	rax, QWORD PTR .LC5[rip]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movq	rax, xmm0
	movq	xmm3, rax
	mulsd	xmm3, QWORD PTR -56[rbp]
	movsd	QWORD PTR -104[rbp], xmm3
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -20[rbp]
	pxor	xmm4, xmm4
	cvtsi2sd	xmm4, DWORD PTR -28[rbp]
	movq	rax, xmm4
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	mulsd	xmm0, QWORD PTR -104[rbp]
	mov	eax, DWORD PTR -24[rbp]
	add	eax, 1
	pxor	xmm2, xmm2
	cvtsi2sd	xmm2, eax
	movapd	xmm1, xmm0
	divsd	xmm1, xmm2
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, 0[0+rax*8]
	lea	rax, BERNOULLI[rip]
	movsd	xmm0, QWORD PTR [rdx+rax]
	addsd	xmm0, xmm1
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, 0[0+rax*8]
	lea	rax, BERNOULLI[rip]
	movsd	QWORD PTR [rdx+rax], xmm0
	jmp	.L16
.L15:
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, 0[0+rax*8]
	lea	rax, BERNOULLI[rip]
	pxor	xmm0, xmm0
	movsd	QWORD PTR [rdx+rax], xmm0
.L16:
	add	DWORD PTR -28[rbp], 1
.L14:
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, DWORD PTR -24[rbp]
	jle	.L17
	add	DWORD PTR -24[rbp], 1
.L13:
	mov	eax, DWORD PTR -24[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jle	.L18
	add	DWORD PTR -20[rbp], 1
.L12:
	mov	eax, DWORD PTR -20[rbp]
	cmp	eax, DWORD PTR -36[rbp]
	jle	.L19
	mov	DWORD PTR -32[rbp], 1
	mov	rax, QWORD PTR -72[rbp]
	movq	xmm0, rax
	call	calculateTanh
	movq	rax, xmm0
	mov	QWORD PTR -48[rbp], rax
.L22:
	cmp	DWORD PTR -32[rbp], 10
	jg	.L23
	mov	rdx, QWORD PTR -72[rbp]
	mov	eax, DWORD PTR -32[rbp]
	movq	xmm0, rdx
	mov	edi, eax
	call	th
	movq	rax, xmm0
	mov	rdx, QWORD PTR -88[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR -88[rbp]
	movsd	xmm0, QWORD PTR [rax]
	subsd	xmm0, QWORD PTR -48[rbp]
	movq	xmm1, QWORD PTR .LC6[rip]
	andpd	xmm0, xmm1
	mov	rax, QWORD PTR -96[rbp]
	movsd	QWORD PTR [rax], xmm0
	add	DWORD PTR -32[rbp], 1
	mov	rax, QWORD PTR -96[rbp]
	movsd	xmm0, QWORD PTR [rax]
	movsd	xmm1, QWORD PTR -80[rbp]
	movsd	xmm2, QWORD PTR .LC7[rip]
	divsd	xmm1, xmm2
	comisd	xmm0, xmm1
	ja	.L22
	jmp	.L24
.L23:
	nop
.L24:
	nop
	add	rsp, 96
	pop	rbx
	pop	r12
	pop	rbp
	ret
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
