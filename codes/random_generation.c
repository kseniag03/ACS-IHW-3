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
