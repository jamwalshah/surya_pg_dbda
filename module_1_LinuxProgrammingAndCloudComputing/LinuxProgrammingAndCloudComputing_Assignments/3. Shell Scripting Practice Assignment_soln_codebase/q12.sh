#!/bin/bash
read -p "Enter a number to find factorial : " num
fact=1
for ((i=num; i>0; i--))
do
	fact=$((fact*i))
done
echo "Factorial of $num is $fact"
