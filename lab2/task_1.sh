#!/bin/bash

user="misha"
file="output_1.txt"

processes=$(ps -u "$user" -o pid,cmd | tail -n +2)
count=$(echo "$processes" | wc -l)

echo "$user: $count" > "$file"
echo "$processes" | awk '{print $1 ":" $2}' >> "$file"
