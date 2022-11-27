.intel_syntax noprefix
.text

.globl factorial				# точка запуска factorial
.type factorial, @function

factorial:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 24

	mov	DWORD PTR -20[rbp], edi		# 1-й аргумент ф-и — int n (в стеке на -20)

	cmp	DWORD PTR -20[rbp], 0		# сравнение n с 0
	je	.L2				# if n == 0 -> L2

	cmp	DWORD PTR -20[rbp], 1		# сравнение n с 1
	jne	.L3				# if n != 1 -> L3

.L2:
	mov	eax, 1				# return 1
	jmp	.L4				# -> L4

.L3:
	mov	eax, DWORD PTR -20[rbp]		# eax = n
	movsx	rbx, eax			# rbx = eax = n
	mov	eax, DWORD PTR -20[rbp]		# eax = n
	sub	eax, 1				# eax = n - 1
	mov	edi, eax			# edi = n - 1, 1-й аргумент ф-и
	call	factorial			# factorial(n - 1)

	imul	rax, rbx			# возвращаемое значение rax = rax * rbx = factorial(n - 1) * n

.L4:
	mov	rbx, QWORD PTR -8[rbp]		# rbx = значение со стека на -8

	leave
	ret

.globl th					# точка запуска th
.type th, @function

th:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48

	mov	DWORD PTR -20[rbp], edi		# 1-й не-double аргумент ф-и — int n (в стеке на -20)
	movsd	QWORD PTR -32[rbp], xmm0	# 1-й double аргумент ф-и — double x (в стеке на -32)
	pxor	xmm0, xmm0			# ИСКЛЮЧАЮЩЕЕ ИЛИ над 64 битами (обнуление регистра)
	movsd	QWORD PTR -8[rbp], xmm0		# в стеке на -8 записывается значение из xmm0 (double res = 0.0)
	mov	DWORD PTR -12[rbp], 1		# в стеке на -12 записывается 1 (int i = 1) !!!!!!!
	jmp	.L6				# -> L6

.L7:
	mov	eax, DWORD PTR -12[rbp]		# eax = i
	add	eax, eax			# eax = i + i = 2 * i
	pxor	xmm0, xmm0			# xmm0 = 0
	cvtsi2sd	xmm0, eax		# xmm0 = (double)(2 * i)
	mov	rax, QWORD PTR .LC1[rip]	# rax = 2 (double const, вычисляется компилятором)
	movapd	xmm1, xmm0			# 2-й double аргумент ф-и — xmm0 = (double)(2 * i)
	movq	xmm0, rax			# 1-й double аргумент ф-и — rax = 2
	call	pow@PLT				# pow(2, 2 * i)

	movsd	QWORD PTR -40[rbp], xmm0	# в стеке на -40 записывается pow(2, 2 * i) (возвращаемое значение с плавающей точкой записывается в регистр xmm0) 

	mov	eax, DWORD PTR -12[rbp]		# eax = i
	add	eax, eax			# eax = 2 * i
	pxor	xmm0, xmm0			# xmm0 = 0
	cvtsi2sd	xmm0, eax		# xmm0 = (double)(2 * i)
	mov	rax, QWORD PTR .LC1[rip]	# rax = 2 (double const)
	movapd	xmm1, xmm0			# 2-й double аргумент ф-и — xmm0 = (double)(2 * i)
	movq	xmm0, rax			# 1-й double аргумент ф-и — rax = 2
	call	pow@PLT				# pow(2, 2 * i)

	movq	rax, xmm0			# rax = xmm0 = pow(2, 2 * i)
	movsd	xmm1, QWORD PTR .LC2[rip]	# xmm1 = 1 (double const, вычисляется компилятором)
	movq	xmm2, rax			# xmm2 = rax = xmm0 = pow(2, 2 * i)
	subsd	xmm2, xmm1			# xmm2 = xmm2 - xmm1 = pow(2, 2 * i) - 1
	movapd	xmm0, xmm2			# xmm0 = xmm2 = pow(2, 2 * i) - 1
	movsd	xmm1, QWORD PTR -40[rbp]	# xmm1 = pow(2, 2 * i)
	mulsd	xmm1, xmm0			# xmm1 = xmm1 * xmm0 = pow(2, 2 * i) * (pow(2, 2 * i) - 1)
	mov	eax, DWORD PTR -12[rbp]		# eax = i
	add	eax, eax			# eax = 2 * i

	lea	rdx, 0[0+rax*8]			# смещение индекса массива
	lea	rax, BERNOULLI[rip]		# rax = *BERNOULLI
	movsd	xmm0, QWORD PTR [rdx+rax]	# xmm0 = BERNOULLI[2 * i]
	mulsd	xmm1, xmm0			# xmm1 = xmm1 * xmm0 = pow(2, 2 * i) * (pow(2, 2 * i) - 1) * BERNOULLI[2 * i]
	movsd	QWORD PTR -40[rbp], xmm1	# в стеке на -40 обновляем значение на pow(2, 2 * i) * (pow(2, 2 * i) - 1) * BERNOULLI[2 * i]
	mov	eax, DWORD PTR -12[rbp]		# eax = i
	add	eax, eax			# eax = 2 * i
	sub	eax, 1				# eax = 2 * i - 1
	pxor	xmm0, xmm0			# xmm0 = 0
	cvtsi2sd	xmm0, eax		# xmm0 = (double)(2 * i - 1)
	mov	rax, QWORD PTR -32[rbp]		# rax = x
	movapd	xmm1, xmm0			# 2-й double аргумент ф-и —  xmm1 = xmm0 = (double)(2 * i - 1)
	movq	xmm0, rax			# 1-й double аргумент ф-и —  xmm0 = rax = x
	call	pow@PLT				# pow(x, 2 * i - 1)

	mulsd	xmm0, QWORD PTR -40[rbp]	# rax = xmm0 * (знач с -40 на стеке) = pow(2, 2 * i) * (pow(2, 2 * i) - 1) * BERNOULLI[2 * i] * pow(x, 2 * i - 1)
	movsd	QWORD PTR -40[rbp], xmm0	# в стеке на -40 обновляем значение на pow(2, 2 * i) * (pow(2, 2 * i) - 1) * BERNOULLI[2 * i] * pow(x, 2 * i - 1)
	mov	eax, DWORD PTR -12[rbp]		# eax = i
	add	eax, eax			# eax = 2 * i
	mov	edi, eax			# 1-й аргумент ф-и —  2 * i
	call	factorial			# factorial(2 * i)

	pxor	xmm1, xmm1			# xmm1 = 0
	cvtsi2sd	xmm1, rax		# xmm1 = (double)factorial(2 * i)
	movsd	xmm0, QWORD PTR -40[rbp]	# xmm0 = pow(2, 2 * i) * (pow(2, 2 * i) - 1) * BERNOULLI[2 * i] * pow(x, 2 * i - 1)
	divsd	xmm0, xmm1			# xmm0 = xmm0 / xmm1 = pow(2, 2 * i) * (pow(2, 2 * i) - 1) * BERNOULLI[2 * i] * pow(x, 2 * i - 1) / factorial(2 * i)
	movsd	xmm1, QWORD PTR -8[rbp]		# xmm1 = (знач с -8 на стеке) = res
	addsd	xmm0, xmm1			# xmm0 = res = res + pow(2, 2 * i) * (pow(2, 2 * i) - 1) * BERNOULLI[2 * i] * pow(x, 2 * i - 1) / factorial(2 * i)
	movsd	QWORD PTR -8[rbp], xmm0		# res = xmm0
	add	DWORD PTR -12[rbp], 1		# ++i

.L6:
	mov	eax, DWORD PTR -12[rbp]		# eax = i
	cmp	eax, DWORD PTR -20[rbp]		# сравнение i с n
	jle	.L7				# if i <= n -> L7 (новая итерация цикла)

	movsd	xmm0, QWORD PTR -8[rbp]		# xmm0 = res
	movq	rax, xmm0			# rax = xmm0
	movq	xmm0, rax			# xmm0 = rax = res (возвращаемое из ф-и значение)

	leave
	ret

.globl calculateTanh				# точка запуска calculateTanh
.type calculateTanh, @function

calculateTanh:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 56

	movsd	QWORD PTR -40[rbp], xmm0	# стек -40: xmm0 = double x (1-й double аргумент ф-и)
	mov	rax, QWORD PTR -40[rbp]		# rax = x
	movq	xmm0, rax			# xmm0 = x
	call	exp@PLT				# exp(x)

	movq	rbx, xmm0			# rbx = exp(x)
	movsd	xmm0, QWORD PTR -40[rbp]	# xmm0 = x
	movq	xmm1, QWORD PTR .LC3[rip]	# xmm1 = 1
	xorpd	xmm0, xmm1			# xmm0 = -x
	movq	rax, xmm0			# rax = xmm0 = -x
	movq	xmm0, rax			# xmm0 = -x
	call	exp@PLT				# exp(-x)

	movq	xmm2, rbx			# xmm2 = rbx = exp(x)
	subsd	xmm2, xmm0			# xmm2 = xmm2 - xmm0 = exp(x) - exp(-x)
	movsd	QWORD PTR -48[rbp], xmm2	# в стеке на -48 записывается xmm2 = exp(x) - exp(-x)
	mov	rax, QWORD PTR -40[rbp]		# rax = x
	movq	xmm0, rax			# xmm0 = x
	call	exp@PLT				# exp(x)

	movsd	QWORD PTR -56[rbp], xmm0	# в стеке на -56 записывается xmm0 = exp(x)
	movsd	xmm0, QWORD PTR -40[rbp]	# xmm0 = x
	movq	xmm1, QWORD PTR .LC3[rip]	# xmm1 = 1
	movapd	xmm3, xmm0			# xmm3 = xmm0 = x
	xorpd	xmm3, xmm1			# xmm3 = -x
	movq	rax, xmm3			# rax = xmm3 = -x
	movq	xmm0, rax			# xmm0 = rax = -x
	call	exp@PLT				# exp(-x)

	movsd	xmm1, QWORD PTR -56[rbp]	# xmm1 = exp(x)
	addsd	xmm1, xmm0			# xmm1 = xmm1 + xmm0 = exp(x) + exp(-x)
	movsd	xmm0, QWORD PTR -48[rbp]	# xmm0 = exp(x) - exp(-x)
	divsd	xmm0, xmm1			# xmm0 = xmm0 / xmm1 = (exp(x) - exp(-x)) / (exp(x) + exp(-x))
	movsd	QWORD PTR -24[rbp], xmm0	# double tanh = xmm0 = (exp(x) - exp(-x)) / (exp(x) + exp(-x))
	movsd	xmm0, QWORD PTR -24[rbp]	# xmm0 = tanh
	movq	rax, xmm0			# rax = tanh
	movq	xmm0, rax			# xmm0 = tanh
	mov	rbx, QWORD PTR -8[rbp]		# rbx = (знач с -8 на стеке)

	leave
	ret

.globl power_series				# точка запуска power_series
.type power_series, @function

power_series:
	push	rbp
	mov	rbp, rsp
	push	r12
	push	rbx
	sub	rsp, 96

	movsd	QWORD PTR -72[rbp], xmm0	# стек -72: x (1-й double аргумент ф-и)
	movsd	QWORD PTR -80[rbp], xmm1	# стек -80: eps (2-й double аргумент ф-и)
	mov	QWORD PTR -88[rbp], rdi		# стек -88: *res (1-й не-double аргумент ф-и, указатель)
	mov	QWORD PTR -96[rbp], rsi		# стек -96: *err (2-й не-double аргумент ф-и, указатель)

	mov	DWORD PTR -36[rbp], 10		# стек -36: 10 (int n = 10)

	movsd	xmm0, QWORD PTR .LC2[rip]	# xmm0 = 1.0 (double const, вычисляется компилятором)
	movsd	QWORD PTR BERNOULLI[rip], xmm0	# BERNOULLI[0] = 1.0
	movsd	xmm0, QWORD PTR .LC4[rip]	# xmm0 = -0.5 (double const, вычисляется компилятором)
	movsd	QWORD PTR BERNOULLI[rip+8], xmm0# BERNOULLI[1] = -0.5

	mov	DWORD PTR -20[rbp], 2		# стек -20: 2 (int i = 2) !!!!!!!!!
	jmp	.L12				# -> L12

.L19:
	mov	DWORD PTR -24[rbp], 0		# стек -24: 0 (int j = 0) !!!!!!!!!
	jmp	.L13				# -> L13

.L18:
	mov	DWORD PTR -28[rbp], 0		# стек -28: 0 (int k = 0) !!!!!!!!!
	jmp	.L14				# -> L14

.L17:
	mov	eax, DWORD PTR -24[rbp]		# eax = j
	mov	edi, eax			# edi = eax = j (1-й аргумент ф-и)
	call	factorial			# factorial(j)

	mov	rbx, rax			# rbx = factorial(j)
	mov	eax, DWORD PTR -24[rbp]		# eax = j
	sub	eax, DWORD PTR -28[rbp]		# eax = j - k
	mov	edi, eax			# edi = eax = j - k (1-й аргумент ф-и)
	call	factorial			# factorial(j - k)

	mov	r12, rax			# r12 = factorial(j - k)
	mov	eax, DWORD PTR -28[rbp]		# eax = k
	mov	edi, eax			# edi = eax = k (1-й аргумент ф-и)
	call	factorial			# factorial(k)

	mov	rdx, r12			# rdx = r12 = factorial(j - k)
	imul	rdx, rax			# rdx = rdx * rax = factorial(j - k) * factorial(k) 
	mov	rcx, rdx			# rcx = rdx = factorial(j - k) * factorial(k) 
	mov	rax, rbx			# rax = rbx = factorial(j)

	cqo					# знаковое расширение содержимого регистра rax до qword в регистрах rax:rdx

	idiv	rcx				# rax = rax / rcx = factorial(j) / (factorial(j - k) * factorial(k))
	pxor	xmm0, xmm0			# xmm0 = 0
	cvtsi2sd	xmm0, rax		# xmm0 = (double)(factorial(j) / (factorial(j - k) * factorial(k)))
	movsd	QWORD PTR -56[rbp], xmm0	# стек -56: ratio = xmm0
	cmp	DWORD PTR -20[rbp], 1		# сравнение i с 1
	jle	.L15				# if i <= 1 -> L15

	mov	eax, DWORD PTR -20[rbp]		# eax = i
	and	eax, 1				# eax = eax & 1
	test	eax, eax			# проверка i на чётность (последний бит)
	jne	.L15				# if i % 2 != 0 -> L15

	pxor	xmm0, xmm0			# xmm0 = 0
	cvtsi2sd	xmm0, DWORD PTR -28[rbp]# xmm0 = (double)k
	mov	rax, QWORD PTR .LC5[rip]	# rax = (-1) (double const, вычисляется компилятором)
	movapd	xmm1, xmm0			# xmm1 = xmm0 = (double)k
	movq	xmm0, rax			# xmm0 = eax = -1
	call	pow@PLT				# pow(-1, k)

	movq	rax, xmm0			# rax = pow(-1, k)
	movq	xmm3, rax			# xmm3 = rax = pow(-1, k)
	mulsd	xmm3, QWORD PTR -56[rbp]	# xmm3 = xmm3 * (знач в стеке на -156) = pow(-1, k) * ratio
	movsd	QWORD PTR -104[rbp], xmm3	# стек -104: xmm3 = ratio
	pxor	xmm0, xmm0			# xmm0 = 0
	cvtsi2sd	xmm0, DWORD PTR -20[rbp]# xmm0 = (double)i
	pxor	xmm4, xmm4			# xmm4 = 0
	cvtsi2sd	xmm4, DWORD PTR -28[rbp]# xmm4 = (double)k
	movq	rax, xmm4			# rax = xmm4 = (double)k
	movapd	xmm1, xmm0			# xmm1 = xmm0 = (double)i
	movq	xmm0, rax			# xmm0 = rax = (double)k
	call	pow@PLT				# pow(k, i)

	mulsd	xmm0, QWORD PTR -104[rbp]	# xmm0 = xmm0 * (знач в стеке на -104) = pow(k, i) * pow(-1, k) * ratio
	mov	eax, DWORD PTR -24[rbp]		# eax = j
	add	eax, 1				# eax = j + 1
	pxor	xmm2, xmm2			# xmm2 = 0
	cvtsi2sd	xmm2, eax		# xmm2 = (double)(j + 1)
	movapd	xmm1, xmm0			# xmm1 = xmm0 = pow(k, i) * pow(-1, k) * ratio
	divsd	xmm1, xmm2			# xmm1 = xmm1 / xmm2 = pow(k, i) * pow(-1, k) * ratio / (j + 1)

	mov	eax, DWORD PTR -20[rbp]		# eax = i
	lea	rdx, 0[0+rax*8]			# смещение индекса в массиве
	lea	rax, BERNOULLI[rip]		# rax = BERNOULLI[i]
	movsd	xmm0, QWORD PTR [rdx+rax]	# xmm0 = BERNOULLI[i]
	addsd	xmm0, xmm1			# BERNOULLI[i] += pow(k, i) * pow(-1, k) / (j + 1)

	mov	eax, DWORD PTR -20[rbp]		# eax = i
	lea	rdx, 0[0+rax*8]			# смещение индекса в массиве 
	lea	rax, BERNOULLI[rip]		# rax = BERNOULLI[i]
	movsd	QWORD PTR [rdx+rax], xmm0	# BERNOULLI[i] = xmm0
	jmp	.L16				# -> L16

.L15:
	mov	eax, DWORD PTR -20[rbp]		# eax = i
	lea	rdx, 0[0+rax*8]			# смещение индекса в массиве
	lea	rax, BERNOULLI[rip]		# rax = BERNOULLI[i]
	pxor	xmm0, xmm0			# xmm0 = 0
	movsd	QWORD PTR [rdx+rax], xmm0	# BERNOULLI[i] = 0.0

.L16:
	add	DWORD PTR -28[rbp], 1		# ++k

.L14:
	mov	eax, DWORD PTR -28[rbp]		# eax = k
	cmp	eax, DWORD PTR -24[rbp]		# сравнение k с j
	jle	.L17				# if k <= j -> L17

	add	DWORD PTR -24[rbp], 1		# ++j

.L13:
	mov	eax, DWORD PTR -24[rbp]		# eax = j
	cmp	eax, DWORD PTR -20[rbp]		# сравнение j с i
	jle	.L18				# if j <= i -> L18

	add	DWORD PTR -20[rbp], 1		# ++i

.L12:
	mov	eax, DWORD PTR -20[rbp]		# eax = i
	cmp	eax, DWORD PTR -36[rbp]		# сравнение i с n (10)
	jle	.L19				# if i <= n -> L19

	mov	DWORD PTR -32[rbp], 1		# int a = 1 (в стеке на -32)
	mov	rax, QWORD PTR -72[rbp]		# rax = x
	movq	xmm0, rax			# xmm0 = rax = x (1-й double аргумент ф-и)
	call	calculateTanh			# calculateTanh(x)

	movq	rax, xmm0			# rax = xmm0 = calculateTanh(x)
	mov	QWORD PTR -48[rbp], rax		# double exact = calculateTanh(x)

.L22:
	cmp	DWORD PTR -32[rbp], 10		# сравнение a с 10
	jg	.L24				# if a > 10 -> L24
	mov	rdx, QWORD PTR -72[rbp]		# rdx = x
	mov	eax, DWORD PTR -32[rbp]		# eax = a
	movq	xmm0, rdx			# xmm0 = rdx = x (1-й double аргумент ф-и)
	mov	edi, eax			# edi = eax = a (1-й не-double аргумент ф-и)
	call	th				# th(a, x)

	movq	rax, xmm0			# rax = xmm0 = th(a, x)
	mov	rdx, QWORD PTR -88[rbp]		# rdx = res
	mov	QWORD PTR [rdx], rax		# *res = rax = th(a, x)
	mov	rax, QWORD PTR -88[rbp]		# rax = *res
	movsd	xmm0, QWORD PTR [rax]		# xmm0 = *res
	subsd	xmm0, QWORD PTR -48[rbp]	# xmm0 = *res - exact
	movq	xmm1, QWORD PTR .LC6[rip]	# использование fabs из библиотеки math.h
	andpd	xmm0, xmm1			# поразрядное логическое И (xmm0 = xmm0 & xmm1)
	mov	rax, QWORD PTR -96[rbp]		# rax = err
	movsd	QWORD PTR [rax], xmm0		# *err = fabs(*res - exact)

	add	DWORD PTR -32[rbp], 1		# ++a
	mov	rax, QWORD PTR -96[rbp]		# rax = err
	movsd	xmm0, QWORD PTR [rax]		# xmm0 = *err
 	movsd	xmm1, QWORD PTR -80[rbp]	# xmm1 = eps
	movsd	xmm2, QWORD PTR .LC7[rip]	# xmm2 = 100 (double const, вычисляется компилятором)
	divsd	xmm1, xmm2			# xmm1 = xmm1 / xmm2 = eps / 100
	comisd	xmm0, xmm1			# сравнение xmm0 (*err) с xmm1 (eps / 100)
	ja	.L22				# if *err > (eps / 100) -> L22

.L24:
	add	rsp, 96
	pop	rbx
	pop	r12
	pop	rbp
	ret

# расчёт констант компилятором

	.size	power_series, .-power_series
	.section	.rodata
	.align 8
.LC1:
	.long	0
	.long	1073741824
	.align 8
.LC2:
	.long	0
	.long	1072693248
	.align 16
.LC3:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC4:
	.long	0
	.long	-1075838976
	.align 8
.LC5:
	.long	0
	.long	-1074790400
	.align 16
.LC6:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC7:
	.long	0
	.long	1079574528
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
