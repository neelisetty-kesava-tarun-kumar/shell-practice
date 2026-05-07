#!/bin/bash

R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
B='\033[0;34m'
M='\033[0;35m'
C='\033[0;36m'
W='\033[0;37m'
N='\033[0m'

LOG_DIR="/home/ec2-user/applogs"
LOG_FILE="$LOG_DIR/$0.log"

if [ ! -d "$LOG_DIR" ]; then
    echo -e "${Y}Log directory does not exist. Creating it...${N}"
    exit 1
fi

FILES_TO_DELETE=$(find "$LOG_DIR" -type f -name "*.log" -mtime +7)
#echo "$FILES_TO_DELETE"


while IFS= read -r filepath; do
    echo "Deleting file: $filepath"
done <<< "$FILES_TO_DELETE" 