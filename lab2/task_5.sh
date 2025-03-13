#!/bin/bash
input_file="output_4.txt"
output_file="output_5.txt"
awk -F'[=:]' '
{
    gsub(/^[ \t]+|[ \t]+$/, "", $2);
    gsub(/^[ \t]+|[ \t]+$/, "", $4);
    gsub(/^[ \t]+|[ \t]+$/, "", $6);
    pid = $2; ppid = $4; art = $6;
    if (prev != "" && ppid != prev) {
        avg = sum/count;
        printf "Average=%s is %.2f\n", prev, avg;
        sum = 0; count = 0;
    }
    print $0;
    sum += art; count++;
    prev = ppid;
}
END {
    if (prev != "") {
        avg = sum/count;
        printf "Average=%s is %.2f\n", prev, avg;
    }
}
' "$input_file" > "$output_file"
