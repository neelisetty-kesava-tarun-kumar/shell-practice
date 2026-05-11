#!/bin/bash


USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/backup.log"
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
W='\033[0;37m'
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #14 days is the default value if user is not provided.

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run this script with root user access $N" 
fi

mkdir -p $LOGS_FOLDER

USAGE(){
    echo -e "$R Usage: $0 <source_directory> <destination_directory> [default 14 days]$N"
    exit 1
}

LOG(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1 " | tee -a $LOGS_FILE
}

if [ $# -lt 2 ]; then
    USAGE
fi

if [ -d $SOURCE_DIR ]; then
    echo -e "$G Source directory $SOURCE_DIR exists. $N"
else
    echo -e "$R Source directory $SOURCE_DIR does not exist. $N"
    exit 1
fi

if [ -d $DEST_DIR ]; then
    echo -e "$G Destination directory $DEST_DIR exists. $N"
else
    echo -e "$R Destination directory $DEST_DIR does not exist. $N"
    exit 1
fi
    exit 1
fi

#Find the older files
FILE=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

echo -e "$Y Backing up files from $SOURCE_DIR to $DEST_DIR $N" 

log "Backup startup from $SOURCE_DIR to $DEST_DIR"
log "Source directory: $SOURCE_DIR"
log "Destination directory: $DEST_DIR"
log "Days: $DAYS"

