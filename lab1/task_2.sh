#!/bin/bash

res=""
while [[ "$line" != q ]];
do
read line
if [[ "$line" != q ]]
then res+="$line "
fi
done
echo "$res"
