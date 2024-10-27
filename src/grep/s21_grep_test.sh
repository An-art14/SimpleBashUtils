#!/bin/bash

PASS_MESSAGE="Integration tests passed successfully (more than or equal 80%)"
FAIL_MESSAGE="Integration tests failed (less than 80%)"
fluorescent_green="\033[92;1m"
color_fl=${fluorescent_green}
vivid_red="\033[38;5;196m"
color_vi=${vivid_red}
COUNTER=0
COUNTER_SUCCESS=0
COUNTER_FAIL=0
DIFF_RES=""
GREP_PATH="./s21_grep"
TEST_FILES="../common/1.txt" 

for ip in "-e name" "-e wish  -e some"
do
    for if1 in -i -v -c -l -n -h ""
    do
        for if2 in "" -i -v -c -l -n -h
        do
            TEST="$if1 $if2 $ip $TEST_FILES"

            $GREP_PATH $TEST > s21_grep.txt
            grep $TEST > grep.txt

            DIFF_RES=$(diff s21_grep.txt grep.txt)
            if [[ "$DIFF_RES" == "" ]]
            then
                (( COUNTER_SUCCESS++ ))
            else
                (( COUNTER_FAIL++ ))
            fi
            (( COUNTER++ ))
        done
    done
done

total=$((COUNTER_SUCCESS + COUNTER_FAIL))
SUCCESS_PERCENT=$(( COUNTER_SUCCESS * 100/total))
FAIL_PERCENT=$(( COUNTER_FAIL * 100/total))
echo -e "${fluorescent_green}ALL: $COUNTER (100%)"
echo -e "${fluorescent_green}SUCCESS: $COUNTER_SUCCESS ($SUCCESS_PERCENT%)"
echo -e "${vivid_red}FAIL: $COUNTER_FAIL ($FAIL_PERCENT%) "

if [ $SUCCESS_PERCENT -ge 80 ]; then
  echo -e "${fluorescent_green}$PASS_MESSAGE"
else 
  echo -e "${vivid_red}$FAIL_MESSAGE"
  exit 1
fi

rm s21_grep.txt grep.txt