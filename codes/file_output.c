#include <stdio.h>

void file_output(double res, double err, const char *result, const char *error, char *filename) {
    FILE *file;
    if ((file = fopen(filename, "w")) != NULL) {
        fprintf(file, result, res);
        fprintf(file, error, err);
        fclose(file);
    }
}
