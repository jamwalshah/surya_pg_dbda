#!/bin/bash
read -p "Enter a : " a
read -p "Enter b : " b
read -p "Enter c : " c
if [ $a -eq $b -a $b -eq $c -a $c -eq $a ]
then
	echo "$a, $b, $c are equal"
elif [ $a -eq $b -o $b -eq $c -o $c -eq $a ]
then
	echo "any two are equal among three"
elif [ $a -gt $b -a $a -gt $c ]
then
	echo "$a is greater"
elif [ $b -gt $a -a $b -gt $c ]
then
	echo "$b is greater"
elif [ $c -gt $a -a $c -gt $b ]
then
	echo "$c is greater"
else
	echo "wrong inputs, enter numbers"
fi

