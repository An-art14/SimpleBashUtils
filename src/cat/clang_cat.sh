#!/bin/bash

fluorescent_green="\033[92;1m"
color_fl=${fluorescent_green}
vivid_red="\033[38;5;196m"
color_vi=${vivid_red}

if clang-format -n s21_cat.c s21_cat.h 2>&1 | grep -q "warning: code should be clang-formatted"; then
    echo -e "${vivid_red}Code is not clang-formatted"
    clang-format -n s21_cat.c s21_cat.h
    exit 1
else
    echo -e "${fluorescent_green}Code is clang-formatted"
fi