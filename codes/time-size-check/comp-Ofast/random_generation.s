	.file	"random_generation.c"
	.text
	.p2align 4
	.globl	random_generation
	.type	random_generation, @function
random_generation:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	xorl	%edi, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	time@PLT
	movq	%rax, %rbx
	movl	%eax, %edi
	call	srand@PLT
	call	rand@PLT
	pxor	%xmm0, %xmm0
	andl	$1, %ebx
	cvtsi2sdl	%eax, %xmm0
	mulsd	.LC0(%rip), %xmm0
	je	.L5
	xorpd	.LC1(%rip), %xmm0
.L5:
	movsd	%xmm0, (%r12)
	call	rand@PLT
	movsd	.LC2(%rip), %xmm0
	pxor	%xmm1, %xmm1
	popq	%rbx
	.cfi_def_cfa_offset 24
	mulsd	MAX_EPS(%rip), %xmm0
	cvtsi2sdl	%eax, %xmm1
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, 0(%rbp)
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE39:
	.size	random_generation, .-random_generation
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	1417048335
	.long	1040785915
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC1:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC2:
	.long	2097152
	.long	1040187392
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
