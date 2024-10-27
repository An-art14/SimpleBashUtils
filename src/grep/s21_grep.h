#ifndef S21_GREP_H
#define S21_GREP_H

#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <string.h>

#define MAX_LENGTH 1024

enum global_flags_grep { e, i, v, c, l, n, h, s, f, o, count_patt, all };

int parser_of_flags(int argc, char *argv[], int *global_flags,
                    char *pattern_str);
void read_files(int argc, char *argv[], int *global_flags, char *pattern_str);
void logic(FILE *file, int *global_flags, char *pattern_str, int argc,
           char *argv[], int j);
void eat_patt_e(char *pattern_str, char *optarg, int *global_flags);

#endif