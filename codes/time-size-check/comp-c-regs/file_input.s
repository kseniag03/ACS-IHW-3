.intel_syntax noprefix
.globl file_input
.type file_input, @function

.section .data
	readFile:	.string		"r"
	notOpenFile:	.string		"Unable to open file '%s'\n"
	doubleFormat:	.string		"%lf"
	readingError:	.string		"Reading file '%s' error\n"
	tooBigEps:	.string		"Epsilon is too big. Max epsilon = %lf\n"

.text

file_input:
	push	rbp
	mov	rbp, rsp

	mov	r13, rdi			# x (1-й аргумент ф-и), записываем в свободный регистр r13
	mov	r14, rsi			# eps (2-й аргумент ф-и), записываем в свободный регистр r14
	mov	r15, rdx			# filename (3-й аргумент ф-и), записываем в свободный регистр r15

	lea	rsi, readFile[rip]		# 2-й аргумент -- "r"
	mov	rdi, r15			# 1-й аргумент -- filename
	call	fopen@PLT			# fopen(filename, "r")

	mov	r12, rax			# r12 (file) = rax = fopen(filename, "r") (возвращаемое значение ф-и)
	cmp	r12, 0				# сравнение file с 0 (NULL)
	jne	.L2				# if file != NULL -> L2

	mov	rsi, r15			# 2-й аргумент -- filename
	lea	rdi, notOpenFile[rip]		# 1-й аргумент -- "Unable to open file '%s'\n"
	call	printf@PLT			# printf("Unable to open file '%s'\n", filename)

	mov	eax, 1				# return 1
	jmp	.EXIT				# -> EXIT

.L2:
	mov	rdx, r13			# 3-й аргумент -- x
	lea	rsi, doubleFormat[rip]		# 2-й аргумент -- "%lf"
	mov	rdi, r12			# 1-й аргумент -- file
	call	__isoc99_fscanf@PLT		# fscanf(file, "%lf", x)

	test	eax, eax			# сравнение результата fscanf(file, "%lf", x) с 0
	jg	.L4				# if fscanf(file, "%lf", x) > 0 -> L4

	mov	rsi, r15			# 2-й аргумент -- filename
	lea	rdi, readingError[rip]		# 1-й аргумент -- "Reading file '%s' error\n"
	call	printf@PLT			# printf ("Reading file '%s' error\n", filename)

	mov	rdi, r12			# 1-й аргумент -- file
	call	fclose@PLT			# fclose(file)

	mov	eax, 1				# return 1
	jmp	.EXIT				# -> EXIT

.L4:
	mov	rdx, r14			# 3-й аргумент -- eps
	lea	rsi, doubleFormat[rip]		# 2-й аргумент -- "%lf"
	mov	rdi, r12			# 1-й аргумент -- file
	call	__isoc99_fscanf@PLT		# fscanf(file, "%lf", eps)

	test	eax, eax			# сравнение результата fscanf(file, "%lf", x) с 0
	jg	.L5				# if fscanf(file, "%lf", x) > 0 -> L5

	mov	rsi, r15			# 2-й аргумент -- filename
	lea	rdi, readingError[rip]		# 1-й аргумент -- "Reading file '%s' error\n"
	call	printf@PLT			# printf ("Reading file '%s' error\n", filename)

	mov	rdi, r12			# 1-й аргумент -- file
	call	fclose@PLT			# fclose(file)

	mov	eax, 1				# return 1
	jmp	.EXIT				# -> EXIT

.L5:
	mov	rax, r14			# rax = x
	movsd	xmm0, QWORD PTR [rax]		# копируем значение double из *eps в xmm0
	movsd	xmm1, MAX_EPS[rip]		# копируем значение double из MAX_EPS в xmm1
	comisd	xmm0, xmm1			# сравниваем *eps и MAX_EPS
	jbe	.L9				# if eps <= MAX_EPS -> L9

	movq	xmm0, MAX_EPS[rip]		# 1-й double-аргумент (MAX_EPS)
	lea	rdi, tooBigEps[rip]		# 1-й не-double аргумент -- "Epsilon is too big. Max epsilon = %lf\n"
	call	printf@PLT			# printf("Epsilon is too big. Max epsilon = %lf\n", MAX_EPS)

	mov	rdi, r12			# 1-й аргумент -- file
	call	fclose@PLT			# fclose(file)

	mov	eax, 1				# return 1
	jmp	.EXIT				# -> EXIT

.L9:
	mov	rdi, r12			# 1-й аргумент -- file
	call	fclose@PLT			# fclose(file)

	mov	eax, 0				# return 0

.EXIT:
	leave
	ret
