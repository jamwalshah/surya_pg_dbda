#!/bin/bash
echo "Enter a year to check leap year : "
read yr
if [[ $((yr%100)) == 0 ]]
then
	echo "Non-Leap year"
else
	if [ $((yr%4)) == 0 ]
	then
		echo "Leap year"
	else
		echo "Non-Leap year"
	fi
fi
