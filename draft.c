#include <stdio.h>
#include <math.h>

long long factorial(int n) {
    if (n == 0 || n == 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

// n-й член последовательности степенного ряда, Bn -- число Бернулли
double th(int n, double x) {
    if (n == 1) {
        return 1;
    }
    return pow(-1, n - 1) * pow(2, 2 * n) * (pow(2, 2 * n) - 1) * Bn(n) * pow(x, 2 * n - 1) / factorial(2 * n);
}

int main()
{
    int n;
    printf("Введите n: ");
    scanf("%d", &n);


    double bernoulli[1000];
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
    // т.е. для суммы степенного ряда берём первые 12 членов
    for (int i = 0; i <= n; ++i) {
        printf("b%d = %lf\n", i, bernoulli[i]);
    }

    int a = 1;
    // exact_ans -- ответ с формулы
    // my_ans -- ответ с разложения в степенной ряд
    while(abs(exact_ans - my_ans) < eps / 100)
    {
        // ...
        a++;
    }


    return 0;
}
