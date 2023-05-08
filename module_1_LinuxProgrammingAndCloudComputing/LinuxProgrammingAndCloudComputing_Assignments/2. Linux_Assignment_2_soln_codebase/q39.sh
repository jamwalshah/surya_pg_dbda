#!/bin/bash
echo "Enter a number : "
read num
fact=1
for ((i=$num; i!=0; i--))
do
	fact=$((fact*i))
#	echo "$fact" #debug
done
echo "Factorial of $num is $fact"
