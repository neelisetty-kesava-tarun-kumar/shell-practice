#!/bin/bash

R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
W='\033[0;37m'
N='\033[0m'

MESSAGE=""
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1"
}

DISK_USAGE=$(df -hT | grep -v Filesystem)

# Generally use 80 or above in production
USAGE_THRESHOLD=3

while IFS= read -r line
do
    USAGE=$(echo "$line" | awk '{print $6}' | cut -d "%" -f1)
    PARTITION=$(echo "$line" | awk '{print $7}')

    if [ "$USAGE" -ge "$USAGE_THRESHOLD" ]; then
        MESSAGE+="High Disk usage on $PARTITION : $USAGE% which is above threshold $USAGE_THRESHOLD% <br>"
    else
        MESSAGE+="Disk usage on $PARTITION : $USAGE% which is below threshold $USAGE_THRESHOLD% <br>"
    fi

done <<< "$DISK_USAGE"

echo -e "$MESSAGE"

sh mail.sh \ "ntarun1894@gmail.com" \ "High Disk Usage Alert on $IP_ADDRESS" \ "$MESSAGE" \ "HIGH_DISK_USAGE" \ "$IP_ADDRESS" \ "DevOps Team"