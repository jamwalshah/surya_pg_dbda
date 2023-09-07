#!/bin/bash
echo "Enter your choice from menu:\n1. date\n2. cal\n3. ls\n4. pwd\n5.exit "
read inp
if [ $inp == 1 ]
then
	#echo "entered 1" #debug
	date
elif [ $inp == 2 ]
then
	#echo "entered 2" #debug
	cal
elif [ $inp == 3 ]
then
	#echo "entered 3" #debug
	ls
elif [ $inp == 4 ]
then
	#echo "entered 4" #debug
	pwd
else
	#echo "entered 5" #debug
	echo "Entered 5, Exiting Program" #debug
	exit 0
fi
