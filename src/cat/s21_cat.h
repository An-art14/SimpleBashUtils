#ifndef S21_CAT_H
#define S21_CAT_H

#include <getopt.h>
#include <stdio.h>

enum global_flags_opt { b, e, n, s, t, v, all };

int parser_of_flags(int argc, char *argv[], int *global_flags);
void read_files(int argc, char *argv[], int *global_flags);
void logic(FILE *file, int *global_flags);

#endif