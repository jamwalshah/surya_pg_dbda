#!/bin/bash
read -p "Enter file name to check its existence : " fnam
if [ -f $fnam ]
then
	echo "$fnam exists in current dir"
else
	echo "$fnam does not exist in current dir"
fi
