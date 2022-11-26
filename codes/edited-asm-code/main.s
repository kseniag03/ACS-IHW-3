.intel_syntax noprefix				# intel-синтаксис
.globl main					# точка запуска main
.type main, @function				# объявление main как функции

.globl	SIZEMAX					# объявление глобальной константы
.globl	VALUEMAX				# объявление глобальной константы

.section .data					# секция объявления переменных 
	SIZEMAX:	.long		100000
	VALUEMAX:	.long		128
	noArg:		.string		"No arguments\n"
	showArg:	.string		"arg = %s\n"
	inputFileName:	.string		"input.txt"
	outputFileName:	.string		"output.txt"
	inputData:	.string		"Input: %s\n"
	outputData:	.string		"Output: %s\n"
	elapsed:	.string		"Elapsed: %ld ns\n"

.text						# секция кода

main:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp
	sub	rsp, 100096

	mov	DWORD PTR -100084[rbp], edi	# 1-й аргумент main — argc (в стеке на -100084)
	mov	QWORD PTR -100096[rbp], rsi	# 2-й аргумент main — argv (в стеке на -100096)

	mov	eax, 100000			# eax = 100000
	mov	rdi, rax			# 1-й аргумент — 100000
	call	malloc@PLT			# выделяем память под строку (str = (char*)malloc(SIZEMAX))

	mov	QWORD PTR -8[rbp], rax		# char *str (в стеке на -8)
	cmp	DWORD PTR -100084[rbp], 1	# сравнение argc с 1
	jle	.NOARGS				# если argc <= 1, переходим к метке NOARGS

	mov	rax, QWORD PTR -100096[rbp]	# rax = argv
	mov	rax, QWORD PTR 8[rax]		# rax = argv[0]
	mov	r12, rax			# arg = argv[0], локальную переменную записываем в свободный регистр r12
	
	lea	rdi, showArg[rip]		# 1-й аргумент — "arg = %s\n"
	mov	rsi, r12			# 2-й аргумент — arg = argv[0]
	call	printf@PLT			# printf("arg = %s\n", arg)

	mov	rdi, r12			# 1-й аргумент — arg
	call	atoi@PLT			# atoi(arg)

	mov	r13d, eax			# option = atoi(arg) (в свободном регистре r13d, double word)
	cmp	r13d, 1				# сравнение option с 1
	jne	.FILEINPUT			# если не равен 1, переходим к файловому выводу (метка FILEINPUT)

	mov	rdi, QWORD PTR -8[rbp]		# 1-й аргумент — str
	mov	esi, 100000			# 2-й аргумент — 100000
	mov	rdx, QWORD PTR stdin[rip]	# 3-й аргумент — stdin (поток ввода)
	call	fgets@PLT			# вывод с консоли: fgets(str, SIZEMAX, stdin)

	jmp	.DOTASK				# переход к метке DOTASK

.FILEINPUT:
	cmp	r13d, 2				# сравнение option с 2
	jne	.RANDOM				# если не равен 2, переходим к псевдослучайной генерации данных (метка RANDOM)

	mov	rdi, QWORD PTR -8[rbp]		# 1-й аргумент — str
	lea	rsi, inputFileName[rip]		# 2-й аргумент — "input.txt"
	call	file_input@PLT			# file_input(str, "input.txt")

	test	eax, eax			# проверяем, что file_input(str, "input.txt") завершается без ошибок (с кодом 0)
	je	.DOTASK				# если равно 0, переход к метке DOTASK

	mov	eax, 1				# return 1
	jmp	.EXIT				# переход к выходу из программы

.RANDOM:
	mov	rdi, QWORD PTR -8[rbp]		# 1-й аргумент — str
	call	random_generation@PLT		# random_generation(str)

	jmp	.DOTASK				# переход к метке DOTASK

.NOARGS:
	lea	rdi, noArg[rip]			# 1-й аргумент — "No arguments\n"
	call	printf@PLT			# printf("No arguments\n")

	mov	eax, 0				# return 0
	jmp	.EXIT				# переход к выходу из программы

.DOTASK:
	lea	rdi, inputData[rip]		# 1-й аргумент — "Input: %s\n"
	mov	rsi, QWORD PTR -8[rbp]		# 2-й аргумент — str
	call	printf@PLT			# printf("Input: %s\n", str)

	mov	edi, 1				# 1-й аргумент для запуска счётчика — 1 (CLOCK_MONOTONIC)
	lea	rsi, -64[rbp]			# 2-й аргумент для запуска счётчика — &start
	call	clock_gettime@PLT		# вызов функции подсчёта времени до формирования строки, т.е. clock_gettime(CLOCK_MONOTONIC, &start)

	mov	r15, QWORD PTR -8[rbp]		# pStr = str, локальную переменную записываем в свободный регистр r15
	mov	QWORD PTR -100080[rbp], 0	# char ans[100000] = ""

	lea	rdi, -100064[rbp]		# 1-й аргумент — указатель на заполняемый массив ans (-100080 + 16 = -100064 (qword))
	mov	esi, 0				# 2-й аргумент — 0 (код символа для заполнения)
	mov	edx, 99984			# 3-й аргумент — 99984 (размер заполняемой части массива в байтах)
	call	memset@PLT			# memset (ans, 0, 99984) — заполнение массива

	mov	rdi, r15			# 1-й аргумент — pStr
	lea	rsi, -100080[rbp]		# 2-й аргумент — ans
	call	form_new_str@PLT		# form_new_str(pStr, ans)

	mov	edi, 1				# 1-й аргумент для запуска счётчика — 1 (CLOCK_MONOTONIC)
	lea	rsi, -80[rbp]			# 2-й аргумент для запуска счётчика — &end
	call	clock_gettime@PLT		# вызов функции подсчёта времени до вывода, т.е. clock_gettime(CLOCK_MONOTONIC, &end)

	mov	rdi, QWORD PTR -80[rbp]		# 1-й аргумент для подсчёта времени — end.tv_sec
	mov	rsi, QWORD PTR -72[rbp]		# 2-й аргумент для подсчёта времени — end.tv_nsec
	mov	rdx, QWORD PTR -64[rbp]		# 3-й аргумент для подсчёта времени — start.tv_sec
	mov	rcx, QWORD PTR -56[rbp]		# 4-й аргумент для подсчёта времени — start.tv_nsec
	call	timespec_difference@PLT		# вызов функции для вычисления времени выполнения задания, т.е. timespec_difference(end, start) (4 аргумента, т.к. передаются структуры с 2-мя полями)
	mov	r14, rax			# elapsed_ns = rax (результат выполнения функции timespec_difference), локальную переменную записываем в свободный регистр r14

	lea	rdi, elapsed[rip]		# 1-й аргумент — "Elapsed: %ld ns\n"
	mov	rsi, r14			# 2-й аргумент — elapsed_ns
	call	printf@PLT			# printf("Elapsed: %ld ns\n", elapsed_ns)

	lea	rdi, outputData[rip]		# 1-й аргумент — "Output: %s\n"
	lea	rsi, -100080[rbp]		# 2-й аргумент — ans
	call	printf@PLT			# printf("Output: %s\n", ans)

	lea	rdi, -100080[rbp]		# 1-й аргумент — ans
	lea	rsi, outputFileName[rip]	# 2-й аргумент — "output.txt"
	call	file_output@PLT			# file_output(ans, "output.txt")

	mov	eax, 0				# return 0

.EXIT:
	leave					# освобождает стек на выходе из функции
	ret					# выполняется выход из программы
