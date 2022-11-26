	.file	"main.c"
	.intel_syntax noprefix
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
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 144
	mov	DWORD PTR -132[rbp], edi
	mov	QWORD PTR -144[rbp], rsi
	mov	QWORD PTR -8[rbp], 0
	mov	QWORD PTR -16[rbp], 0
	cmp	DWORD PTR -132[rbp], 1
	jle	.L2
	cmp	DWORD PTR -132[rbp], 2
	jg	.L3
	lea	rax, .LC0[rip]
	mov	QWORD PTR -8[rbp], rax
	jmp	.L4
.L3:
	mov	rax, QWORD PTR -144[rbp]
	mov	rax, QWORD PTR 16[rax]
	mov	QWORD PTR -8[rbp], rax
.L4:
	cmp	DWORD PTR -132[rbp], 3
	jg	.L5
	lea	rax, .LC1[rip]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L6
.L5:
	mov	rax, QWORD PTR -144[rbp]
	mov	rax, QWORD PTR 24[rax]
	mov	QWORD PTR -16[rbp], rax
.L6:
	mov	rax, QWORD PTR -144[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -28[rbp], eax
	cmp	DWORD PTR -28[rbp], 1
	jne	.L7
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -104[rbp]
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -112[rbp]
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	movsd	xmm0, QWORD PTR -112[rbp]
	movsd	xmm1, QWORD PTR .LC6[rip]
	comisd	xmm0, xmm1
	jbe	.L8
	mov	rax, QWORD PTR .LC6[rip]
	movq	xmm0, rax
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 1
	jmp	.L12
.L7:
	cmp	DWORD PTR -28[rbp], 2
	jne	.L11
	mov	rdx, QWORD PTR -8[rbp]
	lea	rcx, -112[rbp]
	lea	rax, -104[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	file_input@PLT
	mov	DWORD PTR -32[rbp], eax
	cmp	DWORD PTR -32[rbp], 0
	je	.L8
	mov	eax, 1
	jmp	.L12
.L11:
	lea	rdx, -112[rbp]
	lea	rax, -104[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	random_generation@PLT
	jmp	.L8
.L2:
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L12
.L8:
	movsd	xmm0, QWORD PTR -112[rbp]
	mov	rax, QWORD PTR -104[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT
	lea	rax, -80[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	pxor	xmm0, xmm0
	movsd	QWORD PTR -120[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -128[rbp], xmm0
	movsd	xmm0, QWORD PTR -112[rbp]
	mov	rax, QWORD PTR -104[rbp]
	lea	rcx, -128[rbp]
	lea	rdx, -120[rbp]
	mov	rsi, rcx
	mov	rdi, rdx
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	power_series@PLT
	lea	rax, -96[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -80[rbp]
	mov	rdx, QWORD PTR -72[rbp]
	mov	rdi, QWORD PTR -96[rbp]
	mov	rsi, QWORD PTR -88[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	timespec_difference@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rax
	lea	rax, .LC11[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, .LC12[rip]
	mov	QWORD PTR -48[rbp], rax
	lea	rax, .LC13[rip]
	mov	QWORD PTR -56[rbp], rax
	mov	rdx, QWORD PTR -120[rbp]
	mov	rax, QWORD PTR -48[rbp]
	movq	xmm0, rdx
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rdx, QWORD PTR -128[rbp]
	mov	rax, QWORD PTR -56[rbp]
	movq	xmm0, rdx
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	movsd	xmm0, QWORD PTR -128[rbp]
	mov	rax, QWORD PTR -120[rbp]
	mov	rdx, QWORD PTR -16[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, QWORD PTR -48[rbp]
	mov	rdi, rcx
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	file_output@PLT
	mov	eax, 0
.L12:
	leave
	ret
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
