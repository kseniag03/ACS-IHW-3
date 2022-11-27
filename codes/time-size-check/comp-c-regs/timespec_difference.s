.intel_syntax noprefix
.globl	timespec_difference
.type	timespec_difference, @function

.text

timespec_difference:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp

	mov	r12, rdi			# 1-й аргумент timespec_diff — struct timespec a.tv_sec (в свободном регистре r12)
	mov	r13, rsi			# 2-й аргумент timespec_diff — struct timespec a.tv_nsec (в свободном регистре r13)
	mov	r14, rdx			# 3-й аргумент timespec_diff — struct timespec b.tv_sec (в свободном регистре r14)
	mov	r15, rcx			# 4-й аргумент timespec_diff — struct timespec b.tv_nsec (в свободном регистре r15)

	imul	rax, r12, 1000000000		# rax = a.tv_sec * 1000000000 (rax - возвращаемое значение)
	add	rax, r13			# rax = a.tv_sec * 1000000000 + a.tv_nsec
	
	imul	r11, r14, 1000000000		# r11 = b.tv_sec * 1000000000 (r11 - свободный регистр)
	add	r11, r15			# r11 = b.tv_sec * 1000000000 + b.tv_nsec

	sub	rax, r11			# вычитаем время начала: rax = (a.tv_sec * 1000000000 + a.tv_nsec) - (b.tv_sec * 1000000000 + b.tv_nsec)
	
	pop rbp			  		# очистка стека
	ret					# выполняется выход из программы
