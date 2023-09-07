#!/bin/bash
read -p "Enter directory name : " dnam
if [[ -d $dnam ]]
then
	echo "$dnam directory exists"
else
	echo "$dnam directory doesn't exist"
	mkdir $dnam
fi
