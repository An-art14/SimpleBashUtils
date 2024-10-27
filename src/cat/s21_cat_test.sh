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
TEST_FILE="../common/man.txt"

for var in -b -e -n -s -t -v 
  do
    TEST1="$var $TEST_FILE"
    ./s21_cat $TEST1 > s21_cat.txt
    cat $TEST1 > cat.txt
    DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
      if test  "$DIFF_RES" = "Files s21_cat.txt and cat.txt are identical" >/dev/null 2>&1; then
		    COUNTER_SUCCESS=$((COUNTER_SUCCESS + 1))
      else
        COUNTER_FAIL=$((COUNTER_FAIL + 1))
      fi
        (( COUNTER++ ))
  done

for var in -b -e -n -s -t -v 
  do
    for var2 in -b -e -n -s -t -v 
      do
        if [ $var != $var2 ]
          then
          TEST1="$var $var2 $TEST_FILE"
          ./s21_cat $TEST1 > s21_cat.txt
          cat $TEST1 > cat.txt
          if test "$DIFF_RES" = "Files s21_cat.txt and cat.txt are identical" >/dev/null 2>&1; then
		        COUNTER_SUCCESS=$((COUNTER_SUCCESS + 1))
          else
		        COUNTER_FAIL=$((COUNTER_FAIL + 1))
          fi
            (( COUNTER++ ))
        fi
  done
done

for var in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
  do
    for var2 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
      do
        for var3 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
          do
            if [ $var != $var2 ] && [ $var2 != $var3 ] && [ $var != $var3 ]
            then
            TEST1="$var $var2 $var3 $TEST_FILE"
            ./s21_cat $TEST1 > s21_cat.txt
            cat $TEST1 > cat.txt
            DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
              if test "$DIFF_RES" = "Files s21_cat.txt and cat.txt are identical" >/dev/null 2>&1; then
		            COUNTER_SUCCESS=$((COUNTER_SUCCESS + 1))
              else
		            COUNTER_FAIL=$((COUNTER_FAIL + 1))
              fi
                (( COUNTER++ ))
            fi
        done
    done
done

for var in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
do
  for var2 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
  do
      for var3 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
      do
        for var4 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
      do
        if [ $var != $var2 ] && [ $var2 != $var3 ] && [ $var != $var3 ] && [ $var != $var4 ] && [ $var2 != $var4 ] && [ $var3 != $var4 ]
        then
          TEST1="$var $var2 $var3 $TEST_FILE"
          ./s21_cat $TEST1 > s21_cat.txt
          cat $TEST1 > cat.txt
          DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
           if test "$DIFF_RES" = "Files s21_cat.txt and cat.txt are identical" >/dev/null 2>&1; then
		   COUNTER_SUCCESS=$((COUNTER_SUCCESS + 1))
            else
		    COUNTER_FAIL=$((COUNTER_FAIL + 1))
          fi
          (( COUNTER++ ))
        fi
        done
      done
  done
done

for var in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
do
  for var2 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
  do
      for var3 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
      do
        for var4 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
      do
        for var5 in -b -e -n -s -t -v #-E -T --number-nonblank --number --squeeze-blank
      do
        if [ "$var" != "$var2" ] && [ "$var2" != "$var3" ] && [ "$var" != "$var3" ] && [ "$var" != "$var4" ] && [ "$var2" != "$var4" ] && [ "$var3" != "$var4" ] && [ "$var" != "$var5" ] && [ "$var1" != "$var5" ] && [ "$var2" != "$var5" ] && [ "$var3" != "$var5" ] && [ "$var4" != "$var5" ]
then
  TEST1="$var $var2 $var3 $TEST_FILE"
          ./s21_cat $TEST1 > s21_cat.txt
          cat $TEST1 > cat.txt
          DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
           if test "$DIFF_RES" = "Files s21_cat.txt and cat.txt are identical" >/dev/null 2>&1; then
		   COUNTER_SUCCESS=$((COUNTER_SUCCESS + 1))
            else
		    COUNTER_FAIL=$((COUNTER_FAIL + 1))
          fi
          (( COUNTER++ ))
        fi
          done
        done
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
rm -rf s21_cat.txt cat.txt