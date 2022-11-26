.intel_syntax noprefix				# intel-синтаксис
.globl file_input				# точка запуска file_input
.type file_input, @function			# объявление file_input как функции

.section .data					# секция объявления переменных
	readFile:	.string		"r"
	notOpenFile:	.string		"Unable to open file '%s'\n"

.text						# секция кода

file_input:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp

	mov	r12, rdi			# 1-й аргумент file_input — char *pStr (в свободном регистре r12)
	mov	r13, rsi			# 2-й аргумент file_input — char *filename (в свободном регистре r13)

	mov	rdi, r13			# 1-й аргумент — имя файла
	lea	rsi, readFile[rip]		# 2-й аргумент —  формат открытия файла (чтение)
	call	fopen@PLT			# вызов функции открытия файла: file = fopen(filename, "r"), в rax результат функции

	mov	r14, rax			# FILE *file = filename (возвращаемое значение из функции)
	cmp	r14, 0				# сравнение file с 0 (NULL)
	jne	.LOOP				# если file != NULL, переход к метке LOOP

	lea	rdi, notOpenFile[rip]		# 1-й аргумент —  сообщение об ошибке
	mov	rsi, r13			# 2-й аргумент —  имя файла
	call	printf@PLT			# вызов printf("Unable to open file '%s'\n", filename)

	mov	eax, 1				# return 1						
	jmp	.EXIT				# переход к выходу из программы

.LOOP:
	mov	rdi, r14			# 1-й аргумент — file
	call	fgetc@PLT			# вызов ch = fgetc(file) — получение символа из файлового потока
	mov 	r15d, eax			# в свободный регистр r15d записывается результат функции fgetc
	mov	edx, r15d			# скопировать содержимое r15d в edx

	mov	rax, r12			# rax = r12 
	mov	BYTE PTR [rax], dl		# по адресу текущего символа записывается символ из файла (*pStr = ch)
	add	r12, 1				# ++pStr

	cmp	r15d, -1			# сравнение текущего символа с -1
	jne	.LOOP				# если не равен -1, переход к метке LOOP

	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], 0		# по адресу последнего символа записывается конец строки (*pStr = ‘\0’)

	mov	rdi, r14			# 1-й аргумент — file
	call	fclose@PLT			# вызов fclose(file)

	mov	eax, 0				# return 0

.EXIT:
	leave					# освобождает стек на выходе из функции
	ret					# выполняется выход из программы
