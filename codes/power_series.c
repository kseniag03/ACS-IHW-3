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
