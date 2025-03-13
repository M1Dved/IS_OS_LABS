#!/bin/bash
output_file="output_4.txt"
> "$output_file"
for proc in /proc/[0-9]*;
do
    pid=$(basename "$proc")
    if [ -r "$proc/status" ] && [ -r "$proc/sched" ];
    then
        ppid=$(grep -i "^PPid:" "$proc/status" 2>/dev/null | awk '{print $2}')
        sum_exec=$(grep "sum_exec_runtime" "$proc/sched" 2>/dev/null | awk '{print $3}')
        nr_switches=$(grep "nr_switches" "$proc/sched" 2>/dev/null | awk '{print $3}')
        if [ -n "$sum_exec" ] && [ -n "$nr_switches" ] && [ "$nr_switches" -ne 0 ]; 
	then
            art=$(awk -v sum="$sum_exec" -v sw="$nr_switches" 'BEGIN { printf "%.2f", sum/sw }')
            echo "ProcessID=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$art" >> "$output_file"
        fi
    fi
done
sort -t '=' -k3,3n "$output_file" -o "$output_file"
