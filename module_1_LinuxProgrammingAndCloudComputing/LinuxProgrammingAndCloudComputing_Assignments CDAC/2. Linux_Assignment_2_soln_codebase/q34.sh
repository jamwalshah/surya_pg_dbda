#!/bin/bash
echo "Enter a number : "
read num
for ((i=2; i<=$num/2; i++))
do
	rem=$((num%i))
	if [ $rem -eq 0 ]
	then
		echo "non-Prime Number"
		exit 0
	fi
done
echo "Prime Number"

