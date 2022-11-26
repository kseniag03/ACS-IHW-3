.intel_syntax noprefix				# intel-синтаксис
.globl form_new_str				# точка запуска form_new_str
.type form_new_str, @function			# объявление form_new_str как функции

.text						# секция кода

form_new_str:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp
	sub	rsp, 274			# выделяем память на стеке

	mov	r12, rdi			# 1-й аргумент — char *pStr (в свободном регистре r12)
	mov	r13, rsi			# 2-й аргумент — char ans[] (в свободном регистре r13)

	mov	r14w, 0				# short isNumber = 0
	mov	r15w, 0				# short isNegative = 0

	mov	QWORD PTR -272[rbp], 0		# char tmp[256] = "" (на стеке выделена память под временную строку)

	jmp	.TOLOOP				# переход к метке TOLOOP

.LOOP:
	mov	rax, r12			# rax = r12
	movzx	eax, BYTE PTR [rax]		# в eax записываем текущий символ *pStr (байтовый)
	cmp	al, 45				# сравниваем текущий символ (al — байтовый регистр) с 45-м кодом ('-')
	jne	.ADDDIGIT			# если не найден минус, переход к метке ADDDIGIT

	mov	rax, r12			# rax = r12
	add	rax, 1				# rax = pStr + 1
	movzx	eax, BYTE PTR [rax]		# в eax записываем следующий символ *(pStr + 1) (байтовый)
	cmp	al, 47				# сравниваем символ (al — байтовый регистр) с 47-м кодом (c 48-го начинаются цифры)
	jle	.ADDDIGIT			# если меньше или равен 47 (не цифры), переход к метке ADDDIGIT

	mov	rax, r12
	add	rax, 1				# rax = pStr + 1
	movzx	eax, BYTE PTR [rax]		# в eax записываем следующий символ *(pStr + 1) (байтовый)
	cmp	al, 57				# сравниваем символ (al — байтовый регистр) с 57-м кодом (c 58-го заканчиваются цифры)
	jg	.ADDDIGIT			# если больше 57 (не цифры), переход к метке ADDDIGIT

	mov	r15w, 1				# найдено отрицательное число (isNegative = 1)

.ADDDIGIT:
	mov	rax, r12			# rax = r12
	movzx	eax, BYTE PTR [rax]		# в eax записываем текущий символ *pStr (байтовый)		
	cmp	al, 47				# сравниваем символ (al — байтовый регистр) с 47-м кодом (c 48-го начинаются цифры)			
	jle	.CHECKDIGIT			# если меньше или равен 47 (не цифры), переход к метке CHECKDIGIT				

	mov	rax, r12			# rax = r12		
	movzx	eax, BYTE PTR [rax]		# в eax записываем текущий символ *pStr (байтовый)
	cmp	al, 57				# сравниваем символ (al — байтовый регистр) с 57-м кодом (c 58-го заканчиваются цифры)
	jg	.CHECKDIGIT			# если больше 57 (не цифры), переход к метке CHECKDIGIT

	mov	r14w, 1				# найдено число (isNumber = 1)
	mov	rax, r12			# rax = r12
	movzx	eax, BYTE PTR [rax]		# в eax записываем текущий символ *pStr (байтовый)
	mov	BYTE PTR -274[rbp], al		# cToStr[0] = *pStr
	mov	BYTE PTR -273[rbp], 0		# cToStr[1] = '\0'

	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	lea	rsi, -274[rbp]			# 2-й аргумент — cToStr
	call	strcat@PLT			# вызов функции strcat(tmp, cToStr)

	jmp	.NEXTSYM			# переход к метке NEXTSYM

.CHECKDIGIT:
	cmp	r14w, 0				# проверяем, храним ли число (if (isNumber == 0)) 
	je	.NEXTSYM			# если не число, переход к метке NEXTSYM

	mov	r14w, 0				# isNumber = 0 (обнуляем флаг)
	jmp	.CHECKINSIGNZEROS		# переход к метке CHECKINSIGNZEROS

.DELINSIGNZEROS:
	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	mov	rdx, rax			# rdx = rax = strlen(tmp) (3-й аргумент)
	lea	rax, -272[rbp]			# rax = tmp
	add	rax, 1				# rax = tmp + 1

	lea	rdi, -272[rbp]			# rdi = tmp (1-й аргумент)
	mov	rsi, rax			# rsi = rax = tmp + 1 (2-й аргумент)
	call	memmove@PLT			# memmove(tmp, tmp + 1, strlen(tmp))

.CHECKINSIGNZEROS:
	movzx	eax, BYTE PTR -272[rbp]		# в eax записываем tmp[0]
	cmp	al, 48				# сравниаем код символа с 48 (код '0')
	jne	.CHECKNEGATIVE			# если цифра не равна нулю, переход к метке CHECKNEGATIVE

	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	cmp	rax, 1				# сравниваем длину текущей временной строки с 1
	ja	.DELINSIGNZEROS			# если длина (беззнаковая) > 1, переход к метке DELINSIGNZEROS

.CHECKNEGATIVE:
	cmp	r15w, 0				# проверяем, отрицательное ли число (if (isNegative == 0))
	je	.TMPTOANS			# если не отрицательное, переходим к метке TMPTOANS

	movzx	eax, BYTE PTR -272[rbp]		# в eax записываем tmp[0]
	cmp	al, 48				# сравниаем код символа с 48 (код '0')
	jne	.ADDBRACKETS			# если цифра не равна нулю, переход к метке ADDBRACKETS

	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	cmp	rax, 1				# сравниваем длину текущей временной строки с 1
	ja	.DELINSIGNZEROS			# если длина (беззнаковая) > 1, переход к метке

.ADDBRACKETS:
	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	lea	rdx, 1[rax]			# rdx = strlen(tmp) + 1 (3-й аргумент)
	lea	rax, -272[rbp]			# rax = tmp
	add	rax, 1				# rax = tmp + 1

	mov	rdi, rax			# rdi = rax = tmp + 1 (1-й аргумент)
	lea	rsi, -272[rbp]			# rsi = tmp (2-й аргумент)
	call	memmove@PLT			# вызов memmove(tmp + 1, tmp, strlen(tmp) + 1)

	mov	BYTE PTR -272[rbp], 45		# tmp[0] = '-' (45 — код '-')

	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	lea	rdx, 1[rax]			# rdx = strlen(tmp) + 1 (3-й аргумент)
	lea	rax, -272[rbp]			# rax = tmp
	add	rax, 1				# rax = tmp + 1

	mov	rdi, rax			# rdi = rax = tmp + 1 (1-й аргумент)
	lea	rsi, -272[rbp]			# rsi = tmp (2-й аргумент)

	call	memmove@PLT			# вызов memmove(tmp + 1, tmp, strlen(tmp) + 1)

	mov	BYTE PTR -272[rbp], 40		# tmp[0] = '(' (40 — код '(') 

	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	mov	rdx, rax			# rdx = rax = strlen(tmp)
	lea	rax, -272[rbp]			# rax = tmp
	add	rax, rdx			# rax = tmp + strlen(tmp)
	mov	WORD PTR [rax], 41		# tmp[strlen(tmp)] = ')' (или strcat(tmp, ")")) (41 — код ')')

.TMPTOANS:
	mov	rdi, r13			# 1-й аргумент — ans
	lea	rsi, -272[rbp]			# 2-й аргумент — tmp
	call	strcat@PLT			# strcat(ans, tmp)

	mov	rdi, r13			# 1-й аргумент — ans
	call	strlen@PLT			# вызов strlen(ans)

	mov	rdx, rax			# rdx = rax = strlen(ans)
	mov	rax, r13			# rax = ans
	add	rax, rdx			# rax = ans + strlen(ans)
	mov	WORD PTR [rax], 43		# ans[strlen(ans)] = '+' (или strcat(ans, "+")) (43 — код '+')
	mov	BYTE PTR -272[rbp], 0		# tmp[0] = '\0'
	mov	r15w, 0				# isNegative = 0

.NEXTSYM:
	add	r12, 1				# ++pStr

.TOLOOP:
	mov	rax, r12			# rax = r12
	movzx	eax, BYTE PTR [rax]		# в eax записываем текущий символ *pStr (байтовый)
	test	al, al				# проверка, что while (*pStr) == 0
	jne	.LOOP				# переход к метке LOOP, если while (*pStr) != 0

	cmp	r14w, 0				# иначе выходим из цикла и проверяем, храним ли число (if (isNumber == 0))  
	je	.ENDANS				# если не число, переход к метке ENDANS

	mov	rdi, r13			# 1-й аргумент — ans
	lea	rsi, -272[rbp]			# 2-й аргумент — tmp
	call	strcat@PLT			# вызов strcat(ans, tmp)

	mov	rdi, r13			# 1-й аргумент — ans
	call	strlen@PLT			# вызов strlen(ans)

	mov	rdx, rax			# rdx = rax = strlen(ans)
	mov	rax, r13			# rax = ans
	add	rax, rdx			# rax = ans + strlen(ans)
	mov	WORD PTR [rax], 43		# ans[strlen(ans)] = '+' (или strcat(ans, "+")) (43 — код '+')

	mov	BYTE PTR -272[rbp], 0		# tmp[0] = '\0'

.ENDANS:
	mov	rdi, r13			# 1-й аргумент — ans
	call	strlen@PLT			# вызов strlen(ans)

	lea	rdx, -1[rax]			# rdx = strlen(ans) - 1
	mov	rax, r13			# rax = ans
	add	rax, rdx			# rax = ans + strlen(ans) - 1
	mov	BYTE PTR [rax], 0		# ans[strlen(ans) - 1] = '\0' (убираем лишний плюс с конца)

	leave					# освобождает стек на выходе из функции
	ret					# выполняется выход из программы
