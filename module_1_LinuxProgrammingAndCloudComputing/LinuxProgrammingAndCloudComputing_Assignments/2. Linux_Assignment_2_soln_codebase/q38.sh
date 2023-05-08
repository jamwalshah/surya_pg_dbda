#!/bin/bash
echo "Enter the number for which you want table : "
read num
for ((i=0;i<=10;i++))
do
	echo "$num X $i = $((num*i))"
done
