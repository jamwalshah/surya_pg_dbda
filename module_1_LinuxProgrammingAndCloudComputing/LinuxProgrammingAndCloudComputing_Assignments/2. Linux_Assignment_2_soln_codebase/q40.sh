#!/bin/bash
echo "Enter the value for n, for which you want nth term in fibonacci series : "
read num
a=0
b=1
c=$((a+b))
echo "term0 $a"
echo "term1 $b"
for ((i=2; i<=$num;i++))
do
	a=$b
	b=$c
	c=$((a+b))
	echo "term$i $c"
done
