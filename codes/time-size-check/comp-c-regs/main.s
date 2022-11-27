
.intel_syntax noprefix				# intel-синтаксис
.globl main					# точка запуска main
.type main, @function				# объявление main как функции

.globl	BERNOULLI				# объявление глобального массива (числа Бернулли)
.globl	MAX_EPS					# объявление глобальной константы (худшая возможная точность)

.section .data					# секция объявления переменных
	BERNOULLI:	.zero		8000
	MAX_EPS:	.double		0.050000

	showArg:	.string		"arg = %s\n"
	enterValue:	.string		"Enter x:"
	enterEps:	.string		"Enter eps:"
	doubleFormat:	.string		"%lf"

	tooBigEps:	.string		"Epsilon is too big. Max epsilon = %lf\n"
	noArg:		.string		"No arguments\n"

	inputFileName:	.string		"input.txt"
	outputFileName:	.string		"output.txt"

	inputData:	.string		"Input value: %lf, eps: %lf\n"
	elapsed:	.string		"Elapsed: %ld ns\n"
	outputValue:	.string		"Approximate Value: %lf\n"
	outputError:	.string		"Error: %lf\n"

.text						# секция кода

main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 144

	mov	DWORD PTR -132[rbp], edi	# 1-й аргумент main — argc (в стеке на -132)
	mov	QWORD PTR -144[rbp], rsi	# 2-й аргумент main — argv (в стеке на -144)

	cmp	DWORD PTR -132[rbp], 1		# сравнение argc с 1
	jle	.L2				# if argc <= 1 -> L2

	cmp	DWORD PTR -132[rbp], 2		# сравнение argc с 2
	jg	.L3				# if argc > 2 -> L3

	lea	rax, inputFileName[rip]		# rax = "input.txt"
	mov	QWORD PTR -8[rbp], rax		# fileInput = "input.txt"
	jmp	.L4				# -> L4

.L3:
	mov	rax, QWORD PTR -144[rbp]	# rax = argv
	mov	rax, QWORD PTR 16[rax]		# rax = argv[2]
	mov	QWORD PTR -8[rbp], rax		# fileInput = argv[2]

.L4:
	cmp	DWORD PTR -132[rbp], 3		# сравнение argc с 3
	jg	.L5				# if argc > 3 -> L5

	lea	rax, outputFileName[rip]	# rax = "output.txt"
	mov	QWORD PTR -16[rbp], rax		# fileOutput = "output.txt"
	jmp	.L6				# -> L6

.L5:
	mov	rax, QWORD PTR -144[rbp]	# rax = argv
	mov	rax, QWORD PTR 24[rax]		# rax = argv[3]
	mov	QWORD PTR -16[rbp], rax		# fileOutput = argv[3]

.L6:
	mov	rax, QWORD PTR -144[rbp]	# rax = argv
	mov	rax, QWORD PTR 8[rax]		# rax = argv[1]
	mov	r14, rax			# arg = argv[1], локальную переменную записываем в свободный регистр r14

	mov	rsi, r14			# 2-й аргумент -- arg
	lea	rdi, showArg[rip]		# 1-й аргумент -- "arg = %s\n"
	call	printf@PLT			# printf("arg = %s\n", arg)

	mov	rdi, r14			# 1-й аргумент -- arg
	call	atoi@PLT			# atoi(arg)

	mov	r14d, eax			# option = eax = atoi(arg), локальную переменную записываем в свободный регистр r14d
	cmp	r14d, 1				# сравнение option с 1
	jne	.L7				# if option != 1 -> L7

	lea	rdi, enterValue[rip]		# 1-й аргумент -- "Enter x:"
	call	printf@PLT			# printf("Enter x:")

	lea	rsi, -104[rbp]			# 2-й аргумент -- &x
	lea	rdi, doubleFormat[rip]		# 1-й аргумент -- "%lf"
	call	__isoc99_scanf@PLT		# scanf("%lf", &x)

	lea	rdi, enterEps[rip]		# 1-й аргумент -- "Enter eps:"
	call	printf@PLT			# printf("Enter eps:")

	lea	rsi, -112[rbp]			# 2-й аргумент -- &eps
	lea	rdi, doubleFormat[rip]		# 1-й аргумент -- "%lf"
	call	__isoc99_scanf@PLT		# scanf("%lf", &eps)

	movsd	xmm0, QWORD PTR -112[rbp]	# xmm0 = eps (хранение числа с плавающей точкой)
	movsd	xmm1, QWORD PTR MAX_EPS[rip]	# xmm1 = MAX_EPS (хранение числа с плавающей точкой)
	comisd	xmm0, xmm1			# сравнение xmm0 с xmm1
	jbe	.L8				# if eps <= MAX_EPS -> L8

	mov	rax, QWORD PTR MAX_EPS[rip]	# rax = MAX_EPS
	movq	xmm0, rax			# копирует 64 разряда, 1-й double-аргумент
	lea	rdi, tooBigEps[rip]		# 1-й не-double аргумент -- "Epsilon is too big. Max epsilon = %lf\n"
	call	printf@PLT			# printf("Epsilon is too big. Max epsilon = %lf\n", MAX_EPS);

	mov	eax, 1				# return 1
	jmp	.EXIT				# -> EXIT

.L7:
	cmp	r14d, 2				# сравнение option с 2
	jne	.L11				# if option != 2 -> L11

	mov	rdx, QWORD PTR -8[rbp]		# 3-й аргумент -- fileInput
	lea	rsi, -112[rbp]			# 2-й аргумент -- &eps
	lea	rdi, -104[rbp]			# 1-й аргумент -- &x
	call	file_input@PLT			# file_input(&x, &eps, fileInput)

	mov	r12d, eax			# int ret = eax = file_input(&x, &eps, fileInput), локальную переменную записываем в свободный регистр r12d
	cmp	r12d, 0				# сравнение ret с 0
	je	.L8				# if ret == 0 -> L8

	mov	eax, 1				# return 1
	jmp	.EXIT				# -> EXIT

.L11:
	lea	rsi, -112[rbp]			# 2-й аргумент -- &eps
	lea	rdi, -104[rbp]			# 1-й аргумент -- &x
	call	random_generation@PLT		# random_generation(&x, &eps)

	jmp	.L8				# -> L8

.L2:
	lea	rdi, noArg[rip]			# 1-й аргумент -- "No arguments\n"
	call	printf@PLT			# printf("No arguments\n")

	mov	eax, 0				# return 0
	jmp	.EXIT				# -> EXIT

.L8:
	movsd	xmm0, QWORD PTR -112[rbp]	# копируем значение double из eps в xmm0
	mov	rax, QWORD PTR -104[rbp]	# rax = x
	movapd	xmm1, xmm0			# 2-й double аргумент -- eps
	movq	xmm0, rax			# 1-й double аргумент -- x
	lea	rdi, inputData[rip]		# 1-й не-double аргумент -- "Input value: %lf, eps: %lf\n"
	mov	eax, 2				# смещение для получения значения по ссылке
	call	printf@PLT			# printf("Input value: %lf, eps: %lf\n", x, eps)

	lea	rsi, -80[rbp]			# 2-й аргумент для запуска счётчика — &start
	mov	edi, 1				# 1-й аргумент для запуска счётчика — 1 (CLOCK_MONOTONIC)
	call	clock_gettime@PLT		# вызов функции подсчёта времени до начала задания после ввода данных, т.е. clock_gettime(CLOCK_MONOTONIC, &start)

	pxor	xmm0, xmm0			# ИСКЛЮЧАЮЩЕЕ ИЛИ над 64 битами
	movsd	QWORD PTR -120[rbp], xmm0	# копируем значение double из xmm0 в стек на -120 (double res = 0.0) 
	pxor	xmm0, xmm0			# ИСКЛЮЧАЮЩЕЕ ИЛИ над 64 битами 
	movsd	QWORD PTR -128[rbp], xmm0	# копируем значение double из xmm0 в стек на -128 (double err = 0.0)

	movsd	xmm0, QWORD PTR -112[rbp]	# xmm0 = eps
	mov	rax, QWORD PTR -104[rbp]	# rax = x
	lea	rcx, -128[rbp]			# rcx = err
	lea	rdx, -120[rbp]			# rdx = res
	mov	rsi, rcx			# 2-й не-double (указатель) аргумент -- rcx = *err
	mov	rdi, rdx			# 1-й не-double (указатель) аргумент -- rdx = *res
	movapd	xmm1, xmm0			# 1-й double аргумент xmm1 = xmm0 = eps
	movq	xmm0, rax			# 1-й double аргумент xmm0 = rax = x
	call	power_series@PLT		# power_series(x, eps, &res, &err)

	lea	rsi, -96[rbp]			# 2-й аргумент для запуска счётчика — &end
	mov	edi, 1				# 1-й аргумент для запуска счётчика — 1 (CLOCK_MONOTONIC)
	call	clock_gettime@PLT		# вызов функции подсчёта времени до вывода, т.е. clock_gettime(CLOCK_MONOTONIC, &end)

	mov	rdi, QWORD PTR -96[rbp]		# 1-й аргумент для подсчёта времени — end.tv_sec
	mov	rsi, QWORD PTR -88[rbp]		# 2-й аргумент для подсчёта времени — end.tv_nsec
	mov	rcx, QWORD PTR -72[rbp]		# 4-й аргумент для подсчёта времени — start.tv_nsec
	mov	rdx, QWORD PTR -80[rbp]		# 3-й аргумент для подсчёта времени — start.tv_sec
	call	timespec_difference@PLT		# вызов функции для вычисления времени выполнения задания, т.е. timespec_difference(end, start) (4 аргумента, т.к. передаются структуры с 2-мя полями)

	mov	rsi, rax			# 2-й аргумент -- elapsed_ns = rax (результат выполнения функции timespec_difference)
	lea	rdi, elapsed[rip]		# 1-й аргумент -- "Elapsed: %ld ns\n"
	call	printf@PLT			# printf("Elapsed: %ld ns\n", elapsed_ns)

	lea	rax, outputValue[rip]		# rax = "Approximate Value: %lf\n"
	mov	QWORD PTR -48[rbp], rax		# const char *result = "Approximate Value: %lf\n"
	lea	rax, outputError[rip]		# rax = "Error: %lf\n"
	mov	QWORD PTR -56[rbp], rax		# const char *error = "Error: %lf\n"

	mov	rdx, QWORD PTR -120[rbp]	# rdx = res
	mov	rax, QWORD PTR -48[rbp]		# rax = *result
	movq	xmm0, rdx			# копирует 64 разряда, 1-й double-аргумент -- res
	mov	rdi, rax			# 1-й не-double аргумент -- rax = *result
	mov	eax, 1				# смещение для получения значения по указателю
	call	printf@PLT			# printf(result, res)

	mov	rdx, QWORD PTR -128[rbp]	# rdx = err
	mov	rax, QWORD PTR -56[rbp]		# rax = *error
	movq	xmm0, rdx			# копирует 64 разряда, 1-й double-аргумент -- err
	mov	rdi, rax			# 1-й не-double аргумент -- rax = *error
	mov	eax, 1				# смещение для получения значения по указателю
	call	printf@PLT			# printf(error, err)

	movsd	xmm0, QWORD PTR -128[rbp]	# xmm0 = err
	mov	rax, QWORD PTR -120[rbp]	# rax = res

	mov	rdx, QWORD PTR -16[rbp]		# 3-й не-double аргумент -- rdx = fileOutput
	mov	rsi, QWORD PTR -56[rbp]		# 2-й не-double аргумент -- rsi = *error
	mov	rcx, QWORD PTR -48[rbp]		# rcx = *result

	mov	rdi, rcx			# 1-й не-double аргумент -- rdi = rcx = *result
	movapd	xmm1, xmm0			# 2-й double аргумент -- xmm1 = xmm0 = err
	movq	xmm0, rax			# 1-й double аргумент -- xmm0 = rax = res
	call	file_output@PLT			# file_output(res, err, result, error, fileOutput)

	mov	eax, 0				# return 0

.EXIT:
	leave
	ret
