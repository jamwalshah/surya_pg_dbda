#!/bin/bash
read -p "Enter file name : " fil
if [ -f $fil ]
then
	echo "file exists"
	date -r $fil
else
	echo "file does not exist"
fi
