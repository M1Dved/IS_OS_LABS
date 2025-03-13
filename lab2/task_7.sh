#!/bin/bash
declare -A init_read
declare -A pid_cmd
for proc in /proc/[0-9]*;
do
    pid=$(basename "$proc")
    if [ -r "$proc/io" ] && [ -r "$proc/cmdline" ];
    then
        read_bytes=$(grep "^read_bytes:" "$proc/io" 2>/dev/null | awk '{print $2}')
        init_read[$pid]=$read_bytes
        cmd=$(tr "\0" " " < "$proc/cmdline")
        pid_cmd[$pid]="$cmd"
    fi
done
echo "Мониторинг активности ввода-вывода в течение 1 минуты..."
sleep 60
declare -A diff
for proc in /proc/[0-9]*;
do
    pid=$(basename "$proc")
    if [ -r "$proc/io" ]; 
    then
        read_bytes=$(grep "^read_bytes:" "$proc/io" 2>/dev/null | awk '{print $2}')
        if [[ -n "${init_read[$pid]}" ]]; then
            delta=$((read_bytes - init_read[$pid]))
            diff[$pid]=$delta
        fi
    fi
done
result=()
for pid in "${!diff[@]}"; 
do
    result+=("$pid:${pid_cmd[$pid]}:${diff[$pid]}")
done
echo "Три процесса с максимальным приростом read_bytes за 1 минуту:"
printf "%s\n" "${result[@]}" | sort -t ':' -k3,3nr | head -n 3
