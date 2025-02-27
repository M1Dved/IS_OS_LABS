#!/bin/bash

if [[ "$PWD" == "$HOME" ]]
then
    echo "$HOME"
    exit 0
else
    echo "Ошибка"
    exit 1
fi
