PROJECT_NAME = cat

FLAGS = -Wall -Werror -Wextra

all: s21_$(PROJECT_NAME) 
 
s21_$(PROJECT_NAME): 
	gcc $(FLAGS) s21_$(PROJECT_NAME).c -o s21_$(PROJECT_NAME)

test:
	sh s21_cat_test.sh

clean:
	rm -rf s21_$(PROJECT_NAME) 