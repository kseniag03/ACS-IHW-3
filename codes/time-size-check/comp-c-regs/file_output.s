.intel_syntax noprefix
.globl file_output
.type file_output, @function

.section .data
	writeFile:	.string		"w"

.text

file_output:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32

	movsd	QWORD PTR -24[rbp], xmm0	# копируем значение double из xmm0 в стек на -24 (в xmm0 лежит 1-й double аргумент ф-и)
	movsd	QWORD PTR -32[rbp], xmm1	# копируем значение double из xmm1 в стек на -32 (в xmm1 лежит 2-й double аргумент ф-и)

	mov	r13, rdi			# result (1-й не-double аргумент ф-и), записываем в свободный регистр r13
	mov	r14, rsi			# error (2-й не-double аргумент ф-и), записываем в свободный регистр r14
	mov	r15, rdx			# filename (3-й не-double аргумент ф-и), записываем в свободный регистр r15

	lea	rsi, writeFile[rip]		# 2-й аргумент -- "w"
	mov	rdi, r15			# 1-й аргумент -- filename
	call	fopen@PLT			# fopen(filename, "w")

	mov	r12, rax			# r12 (FILE *file) = fopen(filename, "w"), записываем в свободный регистр r12
	cmp	r12, 0				# сравнение file с 0 (NULL)
	je	.EXIT				# if file == NULL -> EXIT

	mov	rdx, QWORD PTR -24[rbp]		# 3-й аргумент -- res (переменная со стека)
	movq	xmm0, rdx			# копирует 64 разряда из источника (xmm0) в назначение (3-й аргумент)
	mov	rsi, r13			# 2-й аргумент -- result (формат вывода)
	mov	rdi, r12			# 1-й аргумент -- file
	call	fprintf@PLT			# fprintf(file, result, res)

	mov	rdx, QWORD PTR -32[rbp]		# 3-й аргумент -- err (переменная со стека)
	movq	xmm0, rdx			# копирует 64 разряда из источника (xmm1) в назначение (3-й аргумент)
	mov	rsi, r14			# 2-й аргумент -- error (формат вывода)
	mov	rdi, r12			# 1-й аргумент -- file
	call	fprintf@PLT			# fprintf(file, error, err)

	mov	rdi, r12			# 1-й аргумент -- file
	call	fclose@PLT			# fclose(file)
.EXIT:
	leave
	ret
