.intel_syntax noprefix
.globl random_generation
.type random_generation, @function

.section .data
	RANDMAX:	.double		2147483647
	M_PI:		.double		3.141593
	HALF:		.double		2
	SIGNCHANGE:	.double		-1

.text

random_generation:
	push	rbp
	mov	rbp, rsp

	mov	r12, rdi			# *x (1-й аргумент ф-и), записываем в свободный регистр r12
	mov	r13, rsi			# *eps (2-й аргумент ф-и), записываем в свободный регистр r13
	mov	edi, 0				# 1-й аргумент -- 0 (NULL)
	call	time@PLT			# time(NULL)			

	mov	r14d, eax			# seed = time(NULL), записываем в свободный регистр r14d
	mov	edi, r14d			# 1-й аргумент -- r14d (seed)
	call	srand@PLT			# srand(seed)

	call	rand@PLT			# rand()

	pxor	xmm0, xmm0			# ИСКЛЮЧАЮЩЕЕ ИЛИ над 64 битами

	cvtsi2sd	xmm0, eax		# сконвертировать doubleword eax (rand()) в значение типа double (число с плавающей точкой), т.е. xmm0 = (double)rand()
	movsd	xmm2, RANDMAX[rip]		# xmm2 = RAND_MAX
	movapd	xmm1, xmm0			# xmm1 = xmm0 = (double)rand() (перемещение значений с плавающей точкой)
	divsd	xmm1, xmm2			# xmm1 = (double)rand() / RAND_MAX
	movsd	xmm0, M_PI[rip]			# xmm0 = M_PI
	mulsd	xmm0, xmm1			# xmm0 = xmm0 * xmm1 = M_PI * ((double)rand()/RAND_MAX)
	movsd	xmm1, HALF[rip]			# xmm1 = 2
	divsd	xmm0, xmm1			# xmm0 = xmm0 / xmm1 = M_PI * ((double)rand()/RAND_MAX) / 2

	mov	rax, r12			# rax = r12 = x
	movsd	QWORD PTR [rax], xmm0		# *x = xmm0 = M_PI * ((double)rand()/RAND_MAX) / 2

	mov	eax, r14d			# eax = r14d = seed
	and	eax, 1				# seed & 1
	test	eax, eax			# if eax % 2 == 0 (проверка последнего бита на равенство единице) 
	je	.EPS				# if seed % 2 == 0 -> EPS

	mov	rax, r12			# rax = x
	movsd	xmm0, QWORD PTR [rax]		# xmm0 = *x
	movq	xmm1, SIGNCHANGE[rip]		# xmm1 = -1

	mov	rax, r12			# rax = x
	movsd	QWORD PTR [rax], xmm0		# *x = xmm0 = (-1) * M_PI * ((double)rand()/RAND_MAX) / 2

.EPS:
	call	rand@PLT			# rand()

	pxor	xmm0, xmm0			# ИСКЛЮЧАЮЩЕЕ ИЛИ над 64 битами

	cvtsi2sd	xmm0, eax		# xmm0 = (double)rand()
	movsd	xmm2, RANDMAX[rip]		# xmm2 = RAND_MAX
	movapd	xmm1, xmm0			# xmm1 = xmm0 = (double)rand()
	divsd	xmm1, xmm2			# xmm1 = (double)rand() / RAND_MAX
	movsd	xmm0, MAX_EPS[rip]		# xmm0 = MAX_EPS = 0.05
	mulsd	xmm0, xmm1			# xmm0 = xmm0 * xmm1 = 0.05 * (double)rand() / RAND_MAX

	mov	rax, r13			# rax = r13 = eps
	movsd	QWORD PTR [rax], xmm0		# *eps = 0.05 * (double)rand() / RAND_MAX (точность от 0 до 0.05)

	leave
	ret
