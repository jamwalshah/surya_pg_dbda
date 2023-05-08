#!/bin/bash
echo "Enter a number to check positive or negative : "
read num
if [[ $num -gt 0 ]]
then
	echo "positive number"
elif [[ $num -lt 0 ]]
then
	echo "negative number"
else
	echo "Zero"
fi
