#!/bin/bash
# pass search path as commandline arg $1
echo "Enter a name : "
read naam
#echo $naam #debug
dirchk=$(ls -l $1 | grep "$naam" | grep -o "^d")
#echo $dirchk #debug
filechk=$(ls -l $1 | grep "$naam" | grep -o "^-")
#echo $filechk #debug
if [[ $dirchk == 'd' ]]
then
	echo "directory"
elif [[ $filechk == '-' ]]
then
	echo "normal file"
else
	echo "exiting else block, $naam file/dir does not exist"
fi
