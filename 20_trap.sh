#!/bin/bash

set -e
trap 'echo "Error at line $LINENO: $BASH_COMMAND"' ERR

USERID=$(id -u)

LOGS_FOLDER="/var/log/shell-script"
mkdir -p $LOGS_FOLDER

LOGS_FILE="$LOGS_FOLDER/$(basename $0).log"

# Colors
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
N='\033[0m'

if [ "$USERID" -ne 0 ]; then
    echo -e "${R}Please run this script with root user access${N}" | tee -a "$LOGS_FILE"
    exit 1 
fi

for package in "$@"
do
    if ! dnf list installed "$package" &>> "$LOGS_FILE"; then
        echo "$package is not installed, installing now" | tee -a "$LOGS_FILE"
        dnf install "$package" &>> "$LOGS_FILE"
        echo -e "${G}$package installation SUCCESS${N}" | tee -a "$LOGS_FILE"
    else
        echo -e "${Y}$package already installed, skipping${N}" | tee -a "$LOGS_FILE"
    fi
done