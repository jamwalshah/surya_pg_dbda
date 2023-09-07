#!/bin/bash
read -p "Enter file1 name : " fil1
read -p "Enter file2 name : " fil2
echo -e "\ncontents of file1 $fil1 : "
cat $fil1
echo -e "\ncontents of file2 $fil2 : "
cat $fil2
cat $fil1 >> $fil2
echo -e "\ncontents of file2 $fil2 after appending : "
cat $fil2
