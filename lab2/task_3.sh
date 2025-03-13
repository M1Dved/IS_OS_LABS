#!/bin/bash

last_pid=$(ps -eo pid,lstart --sort=start_time | tail -n 1 | awk '{print $1}')

echo "$last_pid"
