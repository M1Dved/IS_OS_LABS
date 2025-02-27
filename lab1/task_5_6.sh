#!/bin/bash

read res
if [[ "$#" -ne 1 ]]
then
    echo "Неправильное количество аргумнтов"
    exit 1
fi

grep "WARN" "$res" > 1.log
grep "ERROR" "$res" >> 1.log
