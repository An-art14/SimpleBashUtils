#include "s21_grep.h"

#include <string.h>

int main(int argc, char *argv[]) {
  if (argc < 2) {
    fprintf(stderr, "usage: %s pattern filename\n", argv[0]);

  } else {
    int global_flags[all] = {0};
    char pattern_str[4 * MAX_LENGTH] = {0};
    parser_of_flags(argc, argv, global_flags, pattern_str);
    read_files(argc, argv, global_flags, pattern_str);
  }
  return 0;
}

int parser_of_flags(int argc, char *argv[], int *global_flags,
                    char *pattern_str) {
  int res = 0;
  int sym;

  while ((sym = getopt_long(argc, argv, "e:ivclnhsf:o", NULL, 0)) != -1) {
    switch (sym) {
    case 'e':
      global_flags[e]++;
      eat_patt_e(pattern_str, optarg, global_flags);
      break;
    case 'i':
      global_flags[i]++;
      break;
    case 'v':
      global_flags[v]++;
      break;
    case 'c':
      global_flags[c]++;
      break;
    case 'l':
      global_flags[l]++;
      break;
    case 'n':
      global_flags[n]++;
      break;
    case 'h':
      global_flags[h]++;
      break;
    case 's':
      global_flags[s]++;
      break;
    case 'f':
      global_flags[f]++;
      break;
    case 'o':
      global_flags[o]++;
      break;
    default:
      fprintf(stderr,
              "grep: illegal option -- %c\nusage: cat [-benstuv] [file "
              "...]\n",
              sym);
      res = 1;
      break;
    }
  }
  if (!global_flags[e] && !global_flags[f]) {
    strcat(pattern_str, argv[optind]);
    optind++;
  }
  return res;
}

void eat_patt_e(char *pattern_str, char *optarg, int *global_flags) {
  if (global_flags[count_patt])
    strcat(pattern_str, "|");
  strcat(pattern_str, optarg);
  global_flags[count_patt]++;
}

void read_files(int argc, char *argv[], int *global_flags, char *pattern_str) {
  for (int i = optind; i < argc; i++) {
    FILE *file = fopen(argv[i], "r");
    if (file != NULL) {
      logic(file, global_flags, pattern_str, argc, argv, i);
    } else {
      if (!global_flags[s])
        fprintf(stderr, "grep: %s: No such file or directory\n", argv[i]);
    }
  }
}

void logic(FILE *file, int *global_flags, char *pattern_str, int argc,
           char *argv[], int j) {
  (void)global_flags;
  char line[MAX_LENGTH];
  regex_t struct_pat;
  regmatch_t coord_pat;
  int regomp_fl;
  if (global_flags[i])
    regomp_fl = REG_EXTENDED | REG_ICASE;
  else
    regomp_fl = REG_EXTENDED;
  regcomp(&struct_pat, pattern_str, regomp_fl);
  int count_str = 1;
  int count_check = 0;
  while (fgets(line, MAX_LENGTH, file) != NULL) {
    int check = regexec(&struct_pat, line, 1, &coord_pat, 0);
    if (global_flags[v])
      check = !check;
    if (!check) {
      count_check++;
      if (global_flags[l] && count_check)
        break;
      if (!global_flags[c]) {
        if ((argc - optind > 1) && !global_flags[h])
          printf("%s:", argv[j]);
        if (global_flags[n])
          printf("%d:", count_str);
        printf("%s", line);
      }
    }
    count_str++;
  }
  regfree(&struct_pat);
  if (global_flags[c]) {
    if ((argc - optind > 1) && !global_flags[h])
      printf("%s:", argv[j]);
    printf("%d\n", count_check);
  }
  if (global_flags[l] && count_check) {
    printf("%s\n", argv[j]);
  }
}
