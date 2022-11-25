#include <stdio.h>
#include <math.h>

double bernoulli[1000];

long long factorial(int n) {
    if (n == 0 || n == 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

// n-й член последовательности степенного ряда, Bn -- число Бернулли
double th(int n, double x) {
    double res = 0.0;
    for (int i = 1; i <= n; ++i) {
        res += pow(2, 2 * i) * (pow(2, 2 * i) - 1) * bernoulli[2 * i]  * pow(x, 2 * i - 1) / factorial(2 * i);
    }
    return res;
}

double calculateTanh(double x) {
    double tanh = 0.0;
    tanh = (exp(x) - exp(-x)) / (exp(x) + exp(-x));
    return tanh;
}

int main()
{
    // в описании функции указано, что для большей точности |x| < pi/2
    double x;
    printf("Введите x: ");
    scanf("%lf", &x);

    double eps;
    printf("Введите eps: ");
    scanf("%lf", &eps);

    int n = 10;
    //double bernoulli[1000];
    bernoulli[0] = 1.0;
    bernoulli[1] = -0.5;
    for (int i = 2; i <= n; ++i) {
        for (int j = 0; j <= i; ++j) {
            for (int k = 0; k <= j; ++k) {
                double ratio = factorial(j) / (factorial(j - k) * factorial(k));
                if (i > 1 && i % 2 == 0) {
                    bernoulli[i] += pow(-1, k) * ratio * pow(k, i) / (j + 1);
                } else {
                    bernoulli[i] = 0.0;
                }
            }
        }
    }

    // b12 -- точность теряется, b16 -- сильно теряется, b18 -- переполнение,
    // т.е. для суммы степенного ряда с меньшей погрешностью берём первые 10 членов
    for (int i = 0; i <= n; ++i) {
        printf("b%d = %lf\n", i, bernoulli[i]);
    }
    printf("\n");

    int a = 1;
    double res;
    double exact = calculateTanh(x);
    do {
        if (a >= 11) {
            break;
        }
        res = th(a, x);
        printf("!!!!! %lf\n", res);
        ++a;
    } while (fabs(res - exact) > eps / 100);

    printf("Точное значение: %lf\n", exact);
    printf("Приближённое значение: %lf\n", res);
    printf("Количество итераций: %d\n", a);
    printf("Погрешность: %lf\n", fabs(res - exact));

    return 0;
}
