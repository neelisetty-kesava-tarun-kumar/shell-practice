#!/bin/bash
TO_ADDRESS="$1"
SUBJECT="$2"
MESSAGE_BODY="$3"
ALERT_TYPE="$4"
SERVER_IP="$5"
DevOps_Team="$6"
FINAL_MESSAGE_BODY=$(echo $MESSAGE_BODY | sed "s/'/'\\\''/g")

FINAL_MESSAGE=$(sed "s/DevOps_Team/$6/g" -e "s/ALERT_TYPE/$4/g" -e "s/SERVER_IP/$5/g" -e "s/MESSAGE/$FINAL_MESSAGE_BODY/g"  mail.html)
{
echo "To: $TO_ADDRESS"
echo "Subject: $SUBJECT"
echo "Content-Type: text/html"
echo ""
echo "$FINAL_MESSAGE"
} | msmtp "$TO_ADDRESS"