#!/bin/bash
read -p "Enter basic salary : " bsal
echo "Basic Salary is $bsal" #debug
da=$(($((bsal * 40))/100))
echo "DA is $da" #debug
hra=$(($((bsal * 20))/100))
echo "HRA is $hra" #debug
gsal=$((bsal + da + hra))
echo "Gross Salary is $gsal"
