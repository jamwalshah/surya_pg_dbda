#!/bin/bash
read -p "Enter number to check even or odd : " num
if [ $num = 0 ]
then
	echo "$num is zero"
elif [ $((num%2)) = 0 ]
then
	echo "$num is even"
else
	echo "$num is odd"
fi
