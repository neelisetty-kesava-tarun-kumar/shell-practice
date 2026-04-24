#!/bin/bash 

NUM1=$1

# -gt => greater than
# -lt => less than 
# -eq => equal 
# -ne => not equal

if [$NUM1 -gt 20] ; then
    echo "Given number $NUM1 is greater than 20"
fi
