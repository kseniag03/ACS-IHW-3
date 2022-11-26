.intel_syntax noprefix				# intel-синтаксис
.globl file_output				# точка запуска file_output
.type file_output, @function			# объявление file_output как функции

.section .data					# секция объявления переменных
	writeFile:	.string		"w"	# формат открытия файла (запись)

.text						# секция кода

file_output:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp

	mov	r12, rdi			# 1-й аргумент file_output — char *pStr (в свободном регистре r12)
	mov	r13, rsi			# 2-й аргумент file_output — char *filename (в свободном регистре r13)

	mov	rdi, r13			# 1-й аргумент — имя файла
	lea	rsi, writeFile[rip]		# 2-й аргумент —  формат открытия файла (запись)
	call	fopen@PLT			# вызов функции открытия файла: file = fopen(filename, "w"), в rax результат функции

	mov	r14, rax			# FILE *file = filename (возвращаемое значение из функции)
	cmp	r14, 0				# сравнение file с 0 (NULL)
	je	.EXIT				# если file == NULL, переход к выходу из программы

	jmp	.LOOP				# иначе переход к метке LOOP

.PRINT:
	movsx	eax, al				# eax = al

	mov	edi, eax			# 1-й аргумент — текущий символ (*pStr)
	mov	rsi, r14			# 2-й аргумент — file
	call	fputc@PLT			# вызов fputc(*pStr, file)

	add	r12, 1				# ++pStr

.LOOP:
	mov	rax, r12 			# rax = pStr
	movzx	eax, BYTE PTR [rax]		# вычисление адреса текущего символа (записывается в eax)

	test	al, al				# логическое сравнения значения регистра с нулем
	jne	.PRINT				# если не равно 0, переход к метке PRINT
	mov	rdi, r14			# 1-й аргумент — file
	call	fclose@PLT			# вызов fclose(file)

.EXIT:
	leave					# освобождает стек на выходе из функции
	ret					# выполняется выход из программы
