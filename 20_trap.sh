#!/bin/bash

set -e #ERROR
trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERROR

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
B='\033[0;34m'
M='\033[0;35m'
C='\033[0;36m'
W='\033[0;37m'

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run this script with root user access $N" | tee -a $LOGS_FILE
    exit 1 
fi

mkdir -p $LOGS_FOLDER

for package in $@
do
    dnf list installed $package &>> $LOGS_FILE
    if [ $? -ne 0 ];then
        echo "$package is not installed, installing now"
        dnf install $package -y &>> $LOGS_FILE
        
    else
        echo -e "$G $package is already installed, $Y skipping installation process $N"
    fi
done