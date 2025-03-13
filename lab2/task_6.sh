#!/bin/bash

max_mem=0
max_pid=0
max_info=""
for proc in /proc/[0-9]*;
do
    if [ -r "$proc/status" ];
    then
        pid=$(basename "$proc")
        vmrss=$(grep "^VmRSS:" "$proc/status" 2>/dev/null | awk '{print $2}')
        if [ -n "$vmrss" ];
        then
            if [ "$vmrss" -gt "$max_mem" ]; 
            then
                max_mem=$vmrss
                max_pid=$pid
                pname=$(grep "^Name:" "$proc/status" | awk '{print $2}')
                max_info="PID=$pid, Name=$pname, VmRSS=${vmrss}kB"
            fi
        fi
    fi
done
echo "$max_info"

top -b -n1 -o +%MEM | grep '^ *[0-9]' | head -n 1

