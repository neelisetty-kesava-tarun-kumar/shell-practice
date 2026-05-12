#!/bin/bash

TO_ADDRESS="$1"
SUBJECT="$2"
MESSAGE_BODY="$3"
ALERT_TYPE="$4"
SERVER_IP="$5"
TO_TEAM="$6"

# Read HTML template
#FINAL_MESSAGE=$(cat mail.html)

# Replace placeholders
#FINAL_MESSAGE=$(echo "$FINAL_MESSAGE" | sed "s|TO_TEAM|$TO_TEAM|g")
#FINAL_MESSAGE=$(echo "$FINAL_MESSAGE" | sed "s|ALERT_TYPE|$ALERT_TYPE|g")
#FINAL_MESSAGE=$(echo "$FINAL_MESSAGE" | sed "s|SERVER_IP|$SERVER_IP|g")

# Replace MESSAGE safely
#FINAL_MESSAGE=${FINAL_MESSAGE//MESSAGE/$MESSAGE_BODY}

FINAL_MESSAGE=$(sed "s/TO_TEAM/$TO_TEAM/g" -e "s/ALERT_TYPE/$ALERT_TYPE/g" -e "s/SERVER_IP/$SERVER_IP/g" -e "s/MESSAGE/$MESSAGE_BODY/g" mail.html)

# Send mail using msmtp
{
echo "To: $TO_ADDRESS"
echo "Subject: $SUBJECT"
echo "Content-Type: text/html"
echo ""
echo -e "$FINAL_MESSAGE"
} | msmtp "$TO_ADDRESS"