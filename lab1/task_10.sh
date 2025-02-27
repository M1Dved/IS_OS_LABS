#!/bin/bash

man bash | tr -c '[:alnum:]' '[\n*]' | sort | uniq -c | sort -nr | head -n 3

