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