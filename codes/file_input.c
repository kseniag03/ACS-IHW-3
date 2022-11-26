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
