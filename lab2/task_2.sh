#!/bin/bash

path="/sbin/"
file="output_2.txt"

ps -eo pid,cmd | awk -v directory="$path" '$2 ~ "^"directory {print $1}' > "$file"
