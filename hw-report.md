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
argv[2] -- имя входного файла <br>
argv[3] -- имя выходного файла <br>
Ответ на задание выводится в консоль и в выходной файл <br>

![program-test](https://user-images.githubusercontent.com/114473740/204104126-b2847f84-7187-49a8-8559-9735f3c7029c.png) <br>
________________________

### 5. Результаты тестовых прогонов для различных исходных данных. <br> ###

Тесты можно посмотреть здесь: [ACS-IHW-2/tests](https://github.com/kseniag03/ACS-IHW-2/tree/main/tests) <br>

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

Можно также посмотреть здесь: [ACS-IHW-2/codes](https://github.com/kseniag03/ACS-IHW-2/tree/main/codes) <br>

main.c -- основная функция
```c
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

extern int64_t timespec_difference(struct timespec a, struct timespec b);
extern int file_input(char *pStr,  char *filename);
extern void file_output(char *pStr,  char *filename);
extern void random_generation(char *pStr);
extern void form_new_str(char *pStr, char ans[]);

const int SIZEMAX = 100000;
const int VALUEMAX = 128;

int main (int argc, char** argv) {
    char *arg;
    int option;
    struct timespec start, end;
    int64_t elapsed_ns;
    char *str;
    str = (char*)malloc(SIZEMAX);
    if (argc > 1) {
        arg = argv[1];
        printf("arg = %s\n", arg);
        option = atoi(arg);
        if (option == 1) {
            fgets(str, SIZEMAX, stdin);
        } else if (option == 2) {
            if (file_input(str, "input.txt")) {
                return 1;
            }
        } else {
            random_generation(str);
        }
    } else {
        printf("No arguments\n");
        return 0;
    }
    printf("Input: %s\n", str);
    clock_gettime(CLOCK_MONOTONIC, &start);
    char *pStr;
    pStr = str;
    char ans[100000] = "";
    form_new_str(pStr, ans);
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespec_difference(end, start);
    printf("Elapsed: %ld ns\n", elapsed_ns);
    printf("Output: %s\n", ans);
    file_output(ans, "output.txt");
    return 0;
}
```
<br>

file_input.c -- ввод данных из входного файла "input.txt"
```c
#include <stdio.h>

int file_input(char *pStr,  char *filename) {
    FILE *file;
    if ((file = fopen(filename, "r")) == NULL) {
        printf("Unable to open file '%s'\n", filename);
        return 1;
    }
    int ch;
    do {
        ch = fgetc(file);
        *pStr = ch;
        ++pStr;
    } while(ch != -1);
    *pStr = '\0';
    fclose(file);
    return 0;
}
```
<br>

file_output.c -- вывод данных в выходной файл "output.txt"
```c
#include <stdio.h>

void file_output(char *pStr, char *filename) {
    FILE *file;
    if ((file = fopen(filename, "w")) != NULL) {
        while (*pStr) {
            fprintf(file, "%c", *pStr);
            ++pStr;
        }
        fclose(file);
    }
}
```
<br>

random_generation.c -- псевдослучайная генерация <br>
```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern const int SIZEMAX;
extern const int VALUEMAX;

void random_generation(char *pStr) {
    srand(time(NULL));
    int n = rand() % (SIZEMAX / 2);
    
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

....c -- формирование новой строки согласно условию задачи
```c

```
<br>

________________________

### 7. Тексты программы на языке ассемблера, разработанной вручную или полученной после компиляции и расширенной комментариями. <br> ###

Можно также посмотреть здесь: ACS-IHW-2/codes/edited-asm-code <br>

[main](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/main.s) <br>
[file_input](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/file_input.s) <br>
[file_output](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/file_output.s) <br>
[random_generation](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/random_generation.s) <br>
[timespec_difference](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/timespec_difference.s) <br>
[form_new_str](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/form_new_str.s) <br>

main.s

```assembly
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

```
<br>

file_input.s

```assembly


```
<br>

file_output.s

```assembly


```

<br>

....s

```assembly


```

<br>

random_generation.s

```assembly


```

<br>

timespec_difference.s

```assembly
.intel_syntax noprefix
.globl	timespec_difference
.type	timespec_difference, @function

.text

timespec_difference:
	push	rbp			               # сохраняем rbp на стек
	mov	rbp, rsp		             # присваиваем rbp = rsp

	mov	r12, rdi		             # 1-й аргумент timespec_diff — struct timespec a.tv_sec (в свободном регистре r12)
	mov	r13, rsi		             # 2-й аргумент timespec_diff — struct timespec a.tv_nsec (в свободном регистре r13)
	mov	r14, rdx		             # 3-й аргумент timespec_diff — struct timespec b.tv_sec (в свободном регистре r14)
	mov	r15, rcx		             # 4-й аргумент timespec_diff — struct timespec b.tv_nsec (в свободном регистре r15)

	imul	rax, r12, 1000000000	# rax = a.tv_sec * 1000000000 (rax - возвращаемое значение)
	add	rax, r13		            # rax = a.tv_sec * 1000000000 + a.tv_nsec
	
	imul	r11, r14, 1000000000	# r11 = b.tv_sec * 1000000000 (r11 - свободный регистр)
	add	r11, r15		            # r11 = b.tv_sec * 1000000000 + b.tv_nsec

	sub	rax, r11		            # вычитаем время начала: rax = (a.tv_sec * 1000000000 + a.tv_nsec) - (b.tv_sec * 1000000000 + b.tv_nsec)
	
	pop rbp			  	            # очистка стека
	ret				                  # выполняется выход из программы

```

<br>

________________________

### 8. Текст на ассемблере программы, полученный после компиляции программы на C. <br> ###

Файлы расширения .s есть в папке: ACS-IHW-2/codes/time-size-check/compile-c <br>

[main](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/main.s) <br>
[file_input](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/file_input.s) <br>
[file_output](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/file_output.s) <br>
[random_generation](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/random_generation.s) <br>
[timespec_difference](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/timespec_difference.s) <br>
[form_new_str](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/form_new_str.s) <br>

________________________

### 9. Информацию, подтверждающую выполнение задания в соответствие требованиям на предполагаемую оценку. <br> ###
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
....c <br>
random_generation.c <br>
timespec_difference.c <br>

Для линковки: <br>
`gcc -lc main.o file_input.o file_output.o random_generation.o timespec_difference.o ....o -o a.exe` <br>

Убираем макросы: <br>
endbr64, cdqe, cdq (в random_generation его оставляем, чтобы корректно выполнялось деление), nop <br>

Переписываем .section.data и названия меток (LC0, L1, etc.) для наглядности, убираем код после ret <br>

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

1. Использованы функции с передачей данных через параметры (пр. `call fputc@PLT`), передаём параметры через регистры: di — 1-й аргумент, si — 2-й аргумент, dx — 3-й аргумент, cx — 4-й аргумент (больше в рамках задания не требовалось) <br>
2. Использованы локальные переменные (из глобальных переменных были только константы, см. код main)
3. В комментариях к ассемблеру описана передача параметров и получение возвращаемого значения (описаны аргументы функции и её вызов)
4. В комментариях к ассемблеру описаны аналоги вызовов функций в Си (подписаны аналоги вызываемых функций из кода на Си)

Критерий на 6. <br>

1. Использования регистров процессора для хранения переменных не на стеке (`r8-r15(d)`) (вместо выделения памяти на стеке для локальных переменных использовались свободные регистры, память же выделялась под временную строку в form_new_str, и в main)
2. Комментарии поясняют использование регистров (см. комментарии в п.7. Тексты программы на языке ассемблера)
3. Представлены тестовые прогоны (см. п.4-5 Тесты и результаты прогонов)
4. Представлено сравнение результатов скомпилированной программы и измененной (см. критерий на 9)

Критерий на 7. <br>

1. Реализация программы на Си и ассемблере в виде 6 единиц компиляции
2. Использование файлов для ввода и вывода данных (для ввода с файла необходимо выбрать опцию 2 в командной строке; вывод осуществляется и в консоль, и в файл)
3. Представлены файлы с тестами ([ACS-IHW-2/tests](https://github.com/kseniag03/ACS-IHW-2/tree/main/tests))

Критерий на 8. <br>

1. Использование генерации исходной строки (псевдослучайной). Программа генерирует случайную строку, если в качестве `option` подавался символ, отличный от 1 или 2 (но не NULL)
2. Выбор ввода с консоли, файла или генерации данных через аргументы командной строки (ввод с консоли был необязателен к реализации, поэтому там строку можно считать только до '\n', несколько же строк можно протестировать через файлы)
3. Использование замеров времени формирования новой строки между вводом и выводом данных, реализовано с помощью `clock_gettime`

Критерий на 9. <br>

Для оптимизации по скорости все части программы компилировались с флагом -O3. <br>
Для оптимизации по размеру все части программы компилировались с флагом -Os. <br>
Также для оптимизации использовались флаги -O0, -O1, -O2, -Ofast. <br>

Таблица сравнений приведена ниже: <br>
| Критерий            | Скомпилированный Си | С оптим. -O0 | С оптим. -O1 | С оптим. -O2 | С оптим. -O3 | С оптим. -Os | С оптим. -Ofast |Отредактированный вручную |       
| --------------------|:-------------------:|:------------:|:------------:|:------------:|:------------:|:------------:|:----------------|-------------------------:|
| размер асм-файла    | ... байт         | ... байт  | ... байт  | ... байт  | ... байт  | ... байт  | ... байт     | ... байт              |
| размер испол. файла | ... байт         | ... байт  | ... байт  | ... байт  | ... байт  | ... байт  | ... байт     | ... байт              |
| время работы        | ... ns        | ... ns | ... ns | ... ns | ... ns | ... ns | ... ns    | ... ns             |
<br>

Размер асм-файла == размер 6 файлов расширения .s ([из папки time-size-check](https://github.com/kseniag03/ACS-IHW-2/tree/main/codes/time-size-check)), исполняемый файл находится в этой же папке <br>
Время работы == усреднённое время работы 10 запусков псевдослучаного генератора (т.к. большой размер данных) <br>

Результаты 10 замеров генератора: <br>

Скомп. Си: <br>
...
<br>

Скомп. Си c option: -O0 <br>
...
<br>

Скомп. Си c option: -O1 <br>
...
<br>

Скомп. Си c option: -O2 <br>
...
<br>

Скомп. Си c option: -O3 <br>
...
<br>

Скомп. Си c option: -Os <br>
...
<br>

Скомп. Си c option: -Ofast <br>
...
<br>

Скомп. Си c правками <br>
...
<br>

По времени самый выгодный: с -Os  <br>
(но обгоняет оптимизатор -O3 всего на 0,0001 секунду, а O1 чуть больше, чем на 1 нано секунду; скорее всего, при большем кол-ве замеров он будет работать медленнее) <br>
По размеру файлов асм: с -Os <br>
По размеру файла исполняемого: обычный компил с Си (но выигрывает он не сильно) <br>
Отредактированный вручную ассемблер по времени выигрывает только у скомпилированного Си примерно на 0,000056 секунды, по остальным параметрам он сильно проигрывает <br> 
// не доверяйте мне ассемблер.... <br>


