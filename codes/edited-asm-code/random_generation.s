.intel_syntax noprefix				# intel-синтаксис
.globl random_generation			# точка запуска random_generation
.type random_generation, @function		# объявление random_generation как функции

.text

random_generation:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp

	mov 	eax, SIZEMAX[rip]		# делимое SIZEMAX в eax
	mov	ecx, 2				# делитель 2 в ecx
	cdq					# преобразовывает SIZEMAX в 8-байтовое значение
	idiv 	ecx				# SIZEMAX / 2 (частное сохраняется в eax, остаток в edx)
	mov	r13d, eax			# в свободный регистр r13d (double word) записываем результат деления SIZEMAX / 2

	mov	r12, rdi			# в свободный регистр r12 записываем переданный в ф-ю параметр (pStr)

	mov	edi, 0				# 1-й аргумент — 0 (NULL)
	call	time@PLT			# вызов функции time(NULL)

	mov	edi, eax			# 1-й аргумент — результат вызова time(NULL)
	call	srand@PLT			# вызов функции srand(time(NULL))

	xor 	edx, edx 			# очистка edx, в который запишется остаток от операции деления div
	call	rand@PLT			# вызов функции rand() — делимое, записываемое в eax
	mov	ecx, r13d			# делитель (SIZEMAX / 2) в ecx
	cdq					# преобразовывает rand() в 8-байтовое значение
	idiv 	ecx				# rand() / (SIZEMAX / 2) (частное сохраняется в eax, остаток в edx)

	mov	r11d, edx			# в свободный регистр r11d (double word) записываем остаток (int n = rand() % (SIZEMAX / 2))
	cmp	r11d, 0				# сравнение n с нулём
	jg	.FLAGS				# если n > 0, переходим к метке FLAGS
	add	r11d, 1				# иначе ++n

.FLAGS:
	mov	r10w, 0				# short isNumber = 0
	mov	r15d, 0				# int i = 0
	jmp	.LOOPBEGIN			# переход к метке LOOPBEGIN

.GETCHAR:
	xor 	edx, edx 			# очистка edx, в который запишется остаток от операции деления div
	call	rand@PLT			# вызов функции rand() — делимое, записываемое в eax
	mov	ecx, VALUEMAX[rip]		# делитель VALUEMAX (128) в ecx
	cdq					# преобразовывает rand() в 8-байтовое значение
	idiv	ecx				# rand() / VALUEMAX (частное сохраняется в eax, остаток в edx)

	mov	r14d, edx			# в свободный регистр r14d (double word) записываем остаток (int c = rand() % VALUEMAX)
	cmp	r14d, 31			# сравнение кода символа с 31
	jg	.CHECKNEGATIVE			# если больше 31, переход к метке CHECKNEGATIVE

	sub	r15d, 1				# иначе --i (запускаем цикл заново)
	jmp	.INCINDEX			# переход к метке INCINDEX

.CHECKNEGATIVE:
	cmp	r14d, 47			# сравнение кода символа с 48 (с 48-го начинаются цифры)
	jl	.ADDCLOSESPACE			# если меньше 48, переход к метке ADDCLOSESPACE

	cmp	r14d, 57			# сравнение кода символа с 57 (с 58-го заканчиваются цифры)
	jg	.ADDCLOSESPACE			# если больше 57, переход к метке ADDCLOSESPACE

	cmp	r10w, 0				# проверяем, встретилось ли число (чтобы вставить пробелы)
	jne	.NUMBERFLAG			# если число не закончилось (или не началось), переходим к метке NUMBERFLAG

	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], 32		# по адресу текущего символа записывается пробел (*pStr = ‘ ’)
	add	r12, 1				# ++pStr

	xor 	edx, edx 			# очистка edx, в который запишется остаток от операции деления div
	mov	eax, r14d			# делимое c в eax
	mov 	ecx, 7				# делитель 7 в ecx
	cdq					# преобразовывает c в 8-байтовое значение
	idiv 	ecx				# c / 7
	cmp	edx, 0				# сравниваем остаток от деления с нулём
	jne	.NUMBERFLAG			# если не равен нулю, переход к метке NUMBERFLAG (минус не ставим)

	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], 45		# по адресу текущего символа записывается минус (*pStr = ‘-’)
	add	r12, 1				# ++pStr

.NUMBERFLAG:
	mov	r10w, 1				# isNumber = 1
	jmp	.ADDSYMTOSTR			# переход к метке ADDSYMTOSTR

.ADDCLOSESPACE:
	cmp	r10w, 0				# сравнение isNumber с нулём (не число)
	je	.ADDSYMTOSTR			# если равен нулю, переход к метке ADDSYMTOSTR (не ставим пробел)

	mov	r10w, 0				# иначе isNumber = 0

	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], 32		# по адресу текущего символа записывается пробел (*pStr = ‘ ’)
	add	r12, 1				# ++pStr

.ADDSYMTOSTR:
	mov	edx, r14d			# скопировать содержимое r14d в edx
	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], dl		# по адресу текущего символа записывается символ из файла (*pStr = c)
	add	r12, 1				# ++pStr

.INCINDEX:
	add	r15d, 1				# ++i

.LOOPBEGIN:
	cmp	r15d, r11d			# сравнение i с n
	jl	.GETCHAR			# если меньше, переход к метке GETCHAR (следующая итерация цикла-for)

	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], 0		# по адресу последнего символа записывается конец строки (*pStr = ‘\0’)

	leave					# освобождает стек на выходе из функции
	ret					# выполняется выход из программы
