#!/bin/bash

R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
W='\033[0;37m'
MESSAGE=""
IP_ADDRESS=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)


log(){
    log -e "$(date "+%Y-%m-%d %H:%M:%S") | $1 " | tee -a $LOGS_FILE
}

DISK_USAGE=$(df -hT | grep -v Filesystem)
USAGE_THRESHOLD=3 # Set the threshold for disk usage percentage, Generally, 80% or higher is considered high. I am using 3% for testing purpose, you can change it to 80% or higher.

while IFS= read -r line
do
    USAGE=$(echo "$line" | awk '{print $6}' | cut -d "%" -f1)
    PARTITON=$(echo "$line" | awk '{print $7}')

    if [ "$USAGE" -ge "$USAGE_THRESHOLD" ]; then
        MESSAGE+="$R Disk usage for partition $PARTITON is at $USAGE% which is above the threshold of $USAGE_THRESHOLD% $N \n"
    else
        MESSAGE+="$G Disk usage for partition $PARTITON is at $USAGE% which is below the threshold of $USAGE_THRESHOLD% $N \n"
    fi

done <<< "$DISK_USAGE"

echo -e "$MESSAGE"

sh mail.sh "2200030017cseh@gmail.com" "High disk usage alert on $IP_ADDRESS" "$MESAGE" "HIGH_DISK_USAGE" "$IP_ADDRESS" "DevOps Team"