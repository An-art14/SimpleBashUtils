PROJECT_NAME = grep

FLAGS = -Wall -Werror -Wextra

MAIN = s21_grep

all: s21_$(PROJECT_NAME) 
 
s21_$(PROJECT_NAME): clean
	gcc $(FLAGS) s21_$(PROJECT_NAME).c -o s21_$(PROJECT_NAME)
	
test:
	sh s21_grep_test.sh

clean:
	rm -rf s21_$(PROJECT_NAME)