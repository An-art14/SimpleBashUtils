#include "s21_cat.h"

int main(int argc, char *argv[]) {
  int global_flags[all] = {0};
  if (!parser_of_flags(argc, argv, global_flags))
    read_files(argc, argv, global_flags);

  return 0;
}

int parser_of_flags(int argc, char *argv[], int *global_flags) {
  int res = 0;
  int sym;

  static struct option long_options[] = {{"number-nonblank", 0, 0, 'b'},
                                         {"squeeze-blank", 0, 0, 's'},
                                         {"number", 0, 0, 'n'},
                                         {NULL, 0, 0, 0}};

  while ((sym = getopt_long(argc, argv, "+benstvTE", long_options, 0)) != -1) {
    switch (sym) {
    case 'b':
      global_flags[b]++;
      break;
    case 'n':
      global_flags[n]++;
      break;
    case 's':
      global_flags[s]++;
      break;
    case 'v':
      global_flags[v]++;
      break;
    case 'E':
      global_flags[e]++;
      break;
    case 'T':
      global_flags[t]++;
      break;
    case 'e':
      global_flags[e]++;
      global_flags[v]++;
      break;
    case 't':
      global_flags[t]++;
      global_flags[v]++;
      break;
    default:
      fprintf(stderr,
              "cat: illegal option -- %c\nusage: cat [-benstuv] [file ...]\n",
              sym);
      res = 1;
      break;
    }
  }

  return res;
}

void read_files(int argc, char *argv[], int *global_flags) {
  for (int i = optind; i < argc; i++) {
    FILE *file = fopen(argv[i], "r");
    if (file != NULL) {
      logic(file, global_flags);
    } else {
      fprintf(stderr, "cat: %s: No such file or directory\n", argv[i]);
    }
  }
}

void logic(FILE *file, int *global_flags) {
  int ch;
  int counter = 1, print_ok = 1, null_str = 1;
  while ((ch = fgetc(file)) != EOF) {
    if (ch == EOF) {
      break;
    }

    if (global_flags[n] && !global_flags[b] && print_ok && null_str < 3) {
      printf("%6d\t", counter++);
    }

    if (global_flags[b] && print_ok && ch != '\n') {
      printf("%6d\t", counter++);
    }

    if (ch == '\n') {
      print_ok = 1;
      if (global_flags[s])
        null_str++;
    } else {
      print_ok = 0;
      null_str = 0;
    }

    if (global_flags[t] && ch == '\t') {
      printf("^");
      ch += 64;
    }

    if (global_flags[v] &&
        ((unsigned char)ch < 32 && ch != '\t' && ch != '\n')) {
      printf("^");
      ch += 64;
    }

    if (global_flags[v] && ch == 127) {
      printf("^");
      ch = 63;
    }

    if (null_str < 3) {
      if (global_flags[e] && ch == '\n')
        printf("$");
      putchar(ch);
    }
  }
  fclose(file);
}