#!/bin/bash

# count=1
# while [ $count -le 5 ]; do
#     echo "Counter: $count"
#     ((count++))
# done

echo "While loop has completed."

while IFS= read -r line; do
    echo "Read line: $line"
done < ./21_script_1.sh #Give the input file name to read.
