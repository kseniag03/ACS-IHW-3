#  ИДЗ №3 #
## Markdown report <br> ##

### 1. Ганина Ксения Андреевна (тг для вопросов: @kgnn47) <br> ###
### 2. БПИ212 <br> ###
### 3. Вариант-10 <br> ###

![10](https://user-images.githubusercontent.com/114473740/203939828-fca659d1-2403-47f1-ad71-ae8638240ec7.png) <br>

Прекрасная формула степенного ряда для прекрасного гиперболического тангенса. <br>
![image](https://user-images.githubusercontent.com/114473740/203939928-a4bacb15-f385-4419-bd76-06e317e92d3a.png)
![image](https://user-images.githubusercontent.com/114473740/203940120-9a1b0634-e12e-4d1a-8fe2-192ec2fa7617.png)
________________________

### 4. Тесты, демонстрирующие проверку программ. <br> ###

Формат ввода данных <br>
argc -- число аргументов в функции (если > 1, значит, передали аргументы) <br>
argv -- массив с аргументами, где: <br>
argv[0] -- имя исполняемого файла <br>
argv[1] -- формат ввода (1 -- console, 2 -- file, else -- random generation) <br>
argv[2] -- имя входного файла (если не задан, то по умолчанию input.txt) <br>
argv[3] -- имя выходного файла (если не задан, то по умолчанию output.txt) <br>
Ответ на задание выводится в консоль и в выходной файл <br>

![program-test](https://user-images.githubusercontent.com/114473740/204104126-b2847f84-7187-49a8-8559-9735f3c7029c.png) <br>
________________________

### 5. Результаты тестовых прогонов для различных исходных данных. <br> ###

Тесты можно посмотреть здесь: [ACS-IHW-3/tests](https://github.com/kseniag03/ACS-IHW-3/tree/main/tests) <br>

Ввод с консоли: <br>
 <br>

Ввод из файла: <br>
 <br>
 <br>

Генератор: <br>
 <br>
 <br>
________________________

### 6. Исходные тексты программы на языке C. <br> ###

Можно также посмотреть здесь: [ACS-IHW-3/codes](https://github.com/kseniag03/ACS-IHW-3/tree/main/codes) <br>

main.c -- основная функция
```c
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern int64_t timespec_difference(struct timespec a, struct timespec b);
extern int file_input(double *x, double *eps, char *filename);
extern void file_output(double res, double err, const char *result, const char *error, char *filename);
extern void random_generation(double *x, double *eps);
extern void power_series(double x, double eps, double *res, double *err);

double BERNOULLI[1000];
const double MAX_EPS = 0.05;

int main (int argc, char** argv) {
    char *arg;
    int option;
    struct timespec start, end;
    int64_t elapsed_ns;
    char *fileInput = NULL, *fileOutput = NULL;
    double x, eps;

    if (argc > 1) {
        if (argc <= 2) {
            fileInput = "input.txt";
        } else {
            fileInput = argv[2];
        }
        if (argc <= 3) {
            fileOutput = "output.txt";
        } else {
            fileOutput = argv[3];
        }
        arg = argv[1];
        printf("arg = %s\n", arg);
        option = atoi(arg);
        if (option == 1) {
            printf("Enter x:");
            scanf("%lf", &x);
            printf("Enter eps:");
            scanf("%lf", &eps);
            if (eps > MAX_EPS) {
                printf("Epsilon is too big. Max epsilon = %lf\n", MAX_EPS);
                return 1;
            }
        } else if (option == 2) {
            int ret = file_input(&x, &eps, fileInput);
            if (ret != 0) {
                return 1;
            }
        } else {
            random_generation(&x, &eps);
        }
    } else {
        printf("No arguments\n");
        return 0;
    }
    printf("Input value: %lf, eps: %lf\n", x, eps);
    clock_gettime(CLOCK_MONOTONIC, &start);

    double res = 0.0, err = 0.0;
    power_series(x, eps, &res, &err);

    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespec_difference(end, start);
    printf("Elapsed: %ld ns\n", elapsed_ns);

    const char *result = "Approximate Value: %lf\n";
    const char *error = "Error: %lf\n";
    printf(result, res);
    printf(error, err);
    file_output(res, err, result, error, fileOutput);

    return 0;
}

```
<br>

file_input.c -- ввод данных из входного файла
```c
#include <stdio.h>

extern const double MAX_EPS;

int file_input(double *x, double *eps, char *filename) {
    FILE *file;
    if ((file = fopen(filename, "r")) == NULL) {
        printf("Unable to open file '%s'\n", filename);
        return 1;
    }
    if (fscanf(file, "%lf", x) < 1) {
        printf ("Reading file '%s' error\n", filename);
        fclose(file);
        return 1;
    }
    if (fscanf(file, "%lf", eps) < 1) {
        printf("Reading file '%s' error\n", filename);
        fclose(file);
        return 1;
    }
    if (*eps > MAX_EPS) {
        printf("Epsilon is too big. Max epsilon = %lf\n", MAX_EPS);
        fclose(file);
        return 1;
    }
    fclose(file);
    return 0;
}

```
<br>

file_output.c -- вывод данных в выходной файл
```c
#include <stdio.h>

void file_output(double res, double err, const char *result, const char *error, char *filename) {
    FILE *file;
    if ((file = fopen(filename, "w")) != NULL) {
        fprintf(file, result, res);
        fprintf(file, error, err);
        fclose(file);
    }
}

```
<br>

random_generation.c -- псевдослучайная генерация <br>
```c
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern const double MAX_EPS;

void random_generation(double *x, double *eps) {
    unsigned int seed = time(NULL);
    srand(seed);
    *x = ((double)rand()/(double)(RAND_MAX)) * M_PI / 2;
    if (seed % 2 != 0) {
        *x *= (-1);
    }
    *eps = ((double)rand()/(double)(RAND_MAX)) * MAX_EPS;
}

```
<br>

timespec_difference.c -- вычисление разницы по времени работы
```c
#include <time.h>
#include <stdint.h>

int64_t timespec_difference(struct timespec a, struct timespec b) {
    int64_t timeA, timeB;
    timeA = a.tv_sec;
    timeA *= 1000000000;
    timeA += a.tv_nsec;
    timeB = b.tv_sec;
    timeB *= 1000000000;
    timeB += b.tv_nsec;
    return timeA - timeB;
}

```
<br>

power_series.c -- подсчёт результата двумя способами (формула из условия и расчёт через степенной ряд), вычисление погрешности
```c
#include <math.h>

extern double BERNOULLI[];

long long factorial(int n) {
    if (n == 0 || n == 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

double th(int n, double x) {
    double res = 0.0;
    for (int i = 1; i <= n; ++i) {
        res += pow(2, 2 * i) * (pow(2, 2 * i) - 1) * BERNOULLI[2 * i] * pow(x, 2 * i - 1) / factorial(2 * i);
    }
    return res;
}

double calculateTanh(double x) {
    double tanh = (exp(x) - exp(-x)) / (exp(x) + exp(-x));
    return tanh;
}

void power_series(double x, double eps, double *res, double *err) {
    int n = 10;
    BERNOULLI[0] = 1.0;
    BERNOULLI[1] = -0.5;
    for (int i = 2; i <= n; ++i) {
        for (int j = 0; j <= i; ++j) {
            for (int k = 0; k <= j; ++k) {
                double ratio = factorial(j) / (factorial(j - k) * factorial(k));
                if (i > 1 && i % 2 == 0) {
                    BERNOULLI[i] += pow(-1, k) * ratio * pow(k, i) / (j + 1);
                } else {
                    BERNOULLI[i] = 0.0;
                }
            }
        }
    }
    int a = 1;
    double exact = calculateTanh(x);
    do {
        if (a >= 11) {
            break;
        }
        *res = th(a, x);
        *err = fabs(*res - exact);
        ++a;
    } while (*err > eps / 100);
}

```
<br>

________________________

### 7. Тексты программы на языке ассемблера, разработанной вручную или полученной после компиляции и расширенной комментариями. <br> ###

Можно посмотреть здесь: [ACS-IHW-3/codes/edited-asm-code](https://github.com/kseniag03/ACS-IHW-3/tree/main/codes/edited-asm-code) <br>

[main](https://github.com/kseniag03/ACS-IHW-3/blob/main/codes/edited-asm-code/main.s) <br>
[file_input](https://github.com/kseniag03/ACS-IHW-3/blob/main/codes/edited-asm-code/file_input.s) <br>
[file_output](https://github.com/kseniag03/ACS-IHW-3/blob/main/codes/edited-asm-code/file_output.s) <br>
[random_generation](https://github.com/kseniag03/ACS-IHW-3/blob/main/codes/edited-asm-code/random_generation.s) <br>
[timespec_difference](https://github.com/kseniag03/ACS-IHW-3/blob/main/codes/edited-asm-code/timespec_difference.s) <br>
[power_series](https://github.com/kseniag03/ACS-IHW-3/blob/main/codes/edited-asm-code/power_series.s) <br>

main.s

```assembly

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

```
<br>

file_input.s

```assembly
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

```
<br>

file_output.s

```assembly
.intel_syntax noprefix
.globl file_output
.type file_output, @function

.section .data
	writeFile:	.string		"w"

.text

file_output:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32

	movsd	QWORD PTR -24[rbp], xmm0	# копируем значение double из xmm0 в стек на -24 (в xmm0 лежит 1-й double аргумент ф-и)
	movsd	QWORD PTR -32[rbp], xmm1	# копируем значение double из xmm1 в стек на -32 (в xmm1 лежит 2-й double аргумент ф-и)

	mov	r13, rdi			# result (1-й не-double аргумент ф-и), записываем в свободный регистр r13
	mov	r14, rsi			# error (2-й не-double аргумент ф-и), записываем в свободный регистр r14
	mov	r15, rdx			# filename (3-й не-double аргумент ф-и), записываем в свободный регистр r15

	lea	rsi, writeFile[rip]		# 2-й аргумент -- "w"
	mov	rdi, r15			# 1-й аргумент -- filename
	call	fopen@PLT			# fopen(filename, "w")

	mov	r12, rax			# r12 (FILE *file) = fopen(filename, "w"), записываем в свободный регистр r12
	cmp	r12, 0				# сравнение file с 0 (NULL)
	je	.EXIT				# if file == NULL -> EXIT

	mov	rdx, QWORD PTR -24[rbp]		# 3-й аргумент -- res (переменная со стека)
	movq	xmm0, rdx			# копирует 64 разряда из источника (xmm0) в назначение (3-й аргумент)
	mov	rsi, r13			# 2-й аргумент -- result (формат вывода)
	mov	rdi, r12			# 1-й аргумент -- file
	call	fprintf@PLT			# fprintf(file, result, res)

	mov	rdx, QWORD PTR -32[rbp]		# 3-й аргумент -- err (переменная со стека)
	movq	xmm0, rdx			# копирует 64 разряда из источника (xmm1) в назначение (3-й аргумент)
	mov	rsi, r14			# 2-й аргумент -- error (формат вывода)
	mov	rdi, r12			# 1-й аргумент -- file
	call	fprintf@PLT			# fprintf(file, error, err)

	mov	rdi, r12			# 1-й аргумент -- file
	call	fclose@PLT			# fclose(file)
.EXIT:
	leave
	ret

```

<br>

power_series.s

```assembly
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
	mov	DWORD PTR -12[rbp], 1		# в стеке на -12 записывается 1 (int i = 1)
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

	mov	DWORD PTR -20[rbp], 2		# стек -20: 2 (int i = 2)
	jmp	.L12				# -> L12

.L19:
	mov	DWORD PTR -24[rbp], 0		# стек -24: 0 (int j = 0)
	jmp	.L13				# -> L13

.L18:
	mov	DWORD PTR -28[rbp], 0		# стек -28: 0 (int k = 0)
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

	cqo

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

```

<br>

random_generation.s

```assembly
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

```

<br>

timespec_difference.s

```assembly
.intel_syntax noprefix			# intel-синтаксис
.globl	timespec_difference		# точка запуска timespec_difference
.type	timespec_difference, @function	# объявление timespec_difference как функции

.text					# секция кода

timespec_difference:
	push	rbp			# сохраняем rbp на стек
	mov	rbp, rsp		# присваиваем rbp = rsp

	mov	r12, rdi		# 1-й аргумент timespec_diff — struct timespec a.tv_sec (в свободном регистре r12)
	mov	r13, rsi		# 2-й аргумент timespec_diff — struct timespec a.tv_nsec (в свободном регистре r13)
	mov	r14, rdx		# 3-й аргумент timespec_diff — struct timespec b.tv_sec (в свободном регистре r14)
	mov	r15, rcx		# 4-й аргумент timespec_diff — struct timespec b.tv_nsec (в свободном регистре r15)

	imul	rax, r12, 1000000000	# rax = a.tv_sec * 1000000000 (rax - возвращаемое значение)
	add	rax, r13		# rax = a.tv_sec * 1000000000 + a.tv_nsec
	
	imul	r11, r14, 1000000000	# r11 = b.tv_sec * 1000000000 (r11 - свободный регистр)
	add	r11, r15		# r11 = b.tv_sec * 1000000000 + b.tv_nsec

	sub	rax, r11		# вычитаем время начала: rax = (a.tv_sec * 1000000000 + a.tv_nsec) - (b.tv_sec * 1000000000 + b.tv_nsec)
	
	pop rbp				# очистка стека
	ret				# выполняется выход из программы

```

<br>

________________________

### 8. Текст на ассемблере программы, полученный после компиляции программы на C. <br> ###

Файлы расширения .s есть в папке: [ACS-IHW-3/codes/time-size-check/comp-c](https://github.com/kseniag03/ACS-IHW-3/tree/main/codes/time-size-check/comp-c) <br>
Без опций (-masm=intel и прочих): [ACS-IHW-3/codes/time-size-check/comp-O0](https://github.com/kseniag03/ACS-IHW-3/tree/main/codes/time-size-check/comp-O0) <br>

________________________

### 9. Информация, подтверждающая выполнение задания в соответствие требованиям на предполагаемую оценку. <br> ###
<br>

Компиляция частей кода и линковка: <br>

`gcc -masm=intel \` <br>
    `-fno-asynchronous-unwind-tables \` <br>
    `-fno-jump-tables \` <br>
    `-fno-stack-protector \` <br>
    `-fno-exceptions \` <br>
    `./main.c \` <br>
    `-S -o ./main.s` <br>
`gcc ./main.s -c -o ./main.o` <br>

Аналогичные команды выполнить для всех файлов-функций: <br>
file_input.c <br>
file_output.c <br>
power_series.c <br>
random_generation.c <br>
timespec_difference.c <br>

Для линковки: <br>
`gcc -lc main.o file_input.o file_output.o random_generation.o timespec_difference.o power_series.o -o a.exe -lm` <br>

Убираем макросы: <br>
endbr64, cdqe, cdq, nop; в power_series.s оставляем cqo, чтобы корректно выполнялось перекладывание double значений в регистр rax <br>

Переписываем .section.data для наглядности, убираем код после ret <br>
// в power_series.s оставляем сгенерированные компилятором константы <br>

Убираем лишние присваивания: вместо  <br>
`mov	rax, QWORD PTR -8[rbp]` <br>
`mov	rdi, rax` <br>
сразу пишем <br>
`mov	rdi, QWORD PTR -8[rbp]` <br>

Критерий на 4. <br>

1. Приведено решение задачи на Си (см. п.6. Исходные тексты программы на языке C)
2. В полученный ассемблер добавлены поясняющие комментарии (см. п.7. Тексты программы на языке ассемблера)
3. Из ассемблерной программы убраны лишние макросы (`endbr64, cdqe, cdq, nop`)
4. Модифицированный ассемблер отдельно откомпилирован и скомпонован без использования опций отладки (`gcc ./main.s -c -o ./main.o`)
5. Представлено полное тестовое покрытие (см. п.4-5 Тесты и результаты прогонов)

Критерий на 5. <br>

1. Использованы функции с передачей данных через параметры (пр. `call factorial, call printf@PLT`), передаём параметры через регистры: di — 1-й аргумент, si — 2-й аргумент, dx — 3-й аргумент, cx — 4-й аргумент; double-аргументы передавались через регистры xmm0 (1-й), xmm1(2-й) <br>
2. Использованы локальные переменные (из глобальных были только константа и массив чисел Бернулли, см. код main)
3. В комментариях к ассемблеру описана передача параметров и получение возвращаемого значения (описаны аргументы функции и её вызов)
4. В комментариях к ассемблеру описаны аналоги вызовов функций в Си (подписаны аналоги вызываемых функций из кода на Си)

Критерий на 6. <br>

1. Использования регистров процессора для хранения переменных не на стеке (`r8-r15(d)`) (вместо выделения памяти на стеке для локальных переменных использовались свободные регистры, использовались в функциях работы с файлами, в генерации и вычислении разницы замеров, немного в main)
2. Для передачи double параметров использовались регистры xmm0, xmm1 (более в рамках задания не понадобилось) 
4. Регистр xmm0 также использовался, чтобы получить возвращаемое функцией значения (с плавающей точкой)
5. Комментарии поясняют использование регистров (см. комментарии в п.7. Тексты программы на языке ассемблера)
6. Представлены тестовые прогоны (см. п.4-5 Тесты и результаты прогонов)
7. Представлено сравнение результатов скомпилированной программы и измененной (см. критерий на 9)

Критерий на 7. <br>

1. Реализация программы на Си и ассемблере в виде 6 единиц компиляции
2. Использование файлов для ввода и вывода данных (для ввода с файла необходимо выбрать опцию 2 в командной строке; вывод осуществляется и в консоль, и в файл, можно указать имена входного и выходного файлов, предусмотрены имена по умолчанию)
3. Предусмотрена проверка числа аргументов
4. Представлены файлы с тестами ([ACS-IHW-3/tests](https://github.com/kseniag03/ACS-IHW-3/tree/main/tests))

Критерий на 8. <br>

1. Использование генерации исходных данных (псевдослучайной). Программа генерирует случайные значение и точность, если в качестве `option` подавался символ, отличный от 1 или 2 (но не NULL). Значение x генерируется от -pi/2 до pi/2 (отрицательное при нечётном seed), точность не хуже 0.05
2. Выбор ввода с консоли, файла или генерации данных через аргументы командной строки (ввод с консоли был необязателен к реализации, но он удобен для проверки программы)
3. Использование замеров времени работы программы между вводом и выводом данных, реализовано с помощью `clock_gettime`

Критерий на 9. <br>

Для оптимизации по скорости все части программы компилировались с флагом -O3. <br>
Для оптимизации по размеру все части программы компилировались с флагом -Os. <br>
Также для оптимизации использовались флаги -O0, -O1, -O2, -Ofast. <br>
Скомп. Си немного отличается от комп. с флагом -O0, т.к. при формировании ассемблерного файла учитывались опции (-masm=intel и прочие, список можно увидеть в начале п.9. Информация, подтверждающая выполнение задания в соответствие требованиям на предполагаемую оценку) <br>

Таблица сравнений приведена ниже: <br>
| Критерий            | Скомпилированный Си | С оптим. -O0 | С оптим. -O1 | С оптим. -O2 | С оптим. -O3 | С оптим. -Os | С оптим. -Ofast |Отредактированный вручную |   
| --------------------|:-------------------:|:------------:|:------------:|:------------:|:------------:|:------------:|:----------------|-------------------------:|
| размер асм-файла    | 17 048 байт         | 17 814 байт  | 16 502 байт  | 18 193 байт  | 23 609 байт  | 15 408 байт  | 22 669 байт     | 34 711 байт              |
| размер i-файла      | -		    | 250 892 байт | 330 348 байт | 330 348 байт | 330 348 байт | 316 008 байт | 334 548 байт    | -      	            |
| размер o-файла      | 13 288 байт         | 15 080 байт  | 15 752 байт  | 16 000 байт  | 17 640 байт  | 15 184 байт  | 17 232 байт     | 19 592 байт              |
| размер испол. файла | 17 104 байт         | 17 104 байт  | 17 136 байт  | 17 136 байт  | 21 232 байт  | 17 128 байт  | 21 272 байт     | 26 016 байт              |
| время работы        | 74 049.8 ns         | 68 888.2 ns  | 58 068.4 ns  | 49 228.2 ns  | 54 890.8 ns  | 39 730.8 ns  | 47 138.7 ns     | 52 779.5 ns              |
<br>

Размер асм-файла == размер 6 файлов расширения .s ([из папки time-size-check](https://github.com/kseniag03/ACS-IHW-3/tree/main/codes/time-size-check)), исполняемый файл находится в этой же папке <br>
Размеры i-файлов o-файлов == размеры 6 файлов расширений .i и .o соответственно (из той же папки) <br>
Время работы == усреднённое время работы 10 запусков псевдослучаного генератора (фактор случайности) <br>

Результаты 10 замеров генератора: <br>

Скомп. Си: <br>
38441
70830
67537
45970
63299
74012
80830
120355
98802
80422
<br>

Скомп. Си c option: -O0 <br>
90412
74853
95462
60836
74809
34596
46341
107702
55121
48750
<br>

Скомп. Си c option: -O1 <br>
27993
83102
45777
61848
50601
106750
38495
39595
29729
96794
<br>

Скомп. Си c option: -O2 <br>
42700
78641
55034
30426
35629
37863
39930
109330
33982
28747
<br>

Скомп. Си c option: -O3 <br>
196587
34227
34281
52298
58902
27567
28579
35826
28974
51667
<br>

Скомп. Си c option: -Os <br>
21913
33042
34248
69651
24789
38740
51694
33387
49555
40289
<br>

Скомп. Си c option: -Ofast <br>
146695
22127
32863
25400
48939
30513
50393
28231
32817
53409
<br>

Скомп. Си c правками <br>
60824
36257
54411
46071
50283
66557
41159
81274
42539
48420
<br>

По времени самый выгодный: с -Os  <br>
По размеру файлов асм: с -Os <br>
По размеру файла исполняемого: обычный компил с Си и -O0 (далее -Os и -O1 с -O2) <br>
По размеру i-файлов: с -O0 <br>
По размеру o-файлов: скомп. Си (с учётом опций -masm=intel и прочих) <br>
Отредактированный вручную ассемблер выигрывает по времени работы у скомп. Си, -O0, -O1, O3, по остальным характеристикам проигрывает <br> 


