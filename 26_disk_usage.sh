#!/bin/bash

R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
W='\033[0;37m'
MESSAGE=""

log(){
    log -e "$(date "+%Y-%m-%d %H:%M:%S") | $1 " | tee -a $LOGS_FILE
}

DISK_USAGE=$(df -hT | grep -v Filesystem)
USAGE_THRESHOLD=2 # Set the threshold for disk usage percentage, Generally, 80% or higher is considered high. I am using 2% for testing purpose, you can change it to 80% or higher.

while IFS= read -r line
do
    USAGE=$(df -hT | grep -v Filesystem | awk '{print $6}' | cut -d "%" -f1)
    PARTITON=$(df -hT | grep -v Filesystem | awk '{print $7}')

    if [ "$USAGE" -ge "$USAGE_THRESHOLD" ]; then
        MESSAGE+="$R Disk usage for partition $PARTITON is at $USAGE% which is above the threshold of $USAGE_THRESHOLD% $N"
    else
        MESSAGE+="$G Disk usage for partition $PARTITON is at $USAGE% which is below the threshold of $USAGE_THRESHOLD% $N"
    fi

done <<< "$DISK_USAGE"

echo -e "$MESSAGE"