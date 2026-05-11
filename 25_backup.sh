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

log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1 " | tee -a $LOGS_FILE
}

if [ $# -lt 2 ]; then
    USAGE
fi

if [ -d $SOURCE_DIR ]; then
    echo -e "$G Source directory $SOURCE_DIR exists."
else
    echo -e "$R Source directory $SOURCE_DIR does not exist."
    exit 1
fi

if [ -d $DEST_DIR ]; then
    echo -e "$G Destination directory $DEST_DIR exists."
else
    echo -e "$R Destination directory $DEST_DIR does not exist."
    exit 1
fi

#Find the older files
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

echo -e "$Y Backing up files from $SOURCE_DIR to $DEST_DIR" 

log "Backup startup from $SOURCE_DIR to $DEST_DIR"
log "Source directory: $SOURCE_DIR"
log "Destination directory: $DEST_DIR"
log "Days: $DAYS"

if [ -z "$FILES" ]; then
    log "No files found .. Skipping backup process"
else
    #app-logs-$timestamp.zip in this form it should be
    log "Files to be archived: $FILES"
    TIMESTAMP=$(date "+%F-%H:%M:%S")
    ZIP_FILE_NAME="$DEST_DIR/app-log-$TIMESTAMP.zip"
    echo -e "$Y Achive file name : $ZIP_FILE_NAME"
    
fi