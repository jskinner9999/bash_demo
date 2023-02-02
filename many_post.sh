#!/bin/bash

. ./env.sh

MAX1=$((MAX+0))
MIN1=$((MIN+0))

while :; do
read -p "Enter a number between ${MIN1} and ${MAX1}: " num1
  [[ $num1 =~ ^[0-9]+$ ]]| { echo "1Enter a valid number ${MIN} ${MAX}"; continue; }
  if ((num1 >= MIN1 && num1 <= MAX1)); then
    echo "valid number"
    break
  else
    echo "number out of range, try again"
  fi
done
while :; do
read -p "Enter a number between ${MIN1} and ${MAX1}: " num2
  [[ $num2 =~ ^[0-9]+$ ]]| { echo "2Enter a valid number"; continue; }
  if ((num2 >= MIN1 && num2 <= MAX1)); then
    echo "valid number"
    break
  else
    echo "number out of range, try again"
  fi
done

read -p "ENTER PREFIX:" PREFIX1

echo ${PREFIX1} "--" ${num1} "   " ${num2}

# for i in $(seq 0 50) ; ./post.sh (www-$i); done

for i in $(seq $num1 $num2) 
do 
echo "${PREFIX1}-${i}" 
./post.sh "${PREFIX1}-${i}"
done


