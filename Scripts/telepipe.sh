#!/bin/bash

apitoken=$(pass show local/telebot/terminalpiper)
chatid="5382159749"

if [ -z "$apitoken" ]; then
    echo "No api_token found"
    exit 1
fi

# Check if the -i cli flag was used
if [ "$1" == "-i" ]; then
    # Check if the -i cli flag was used with a second argument
    if [ -z "$2" ]; then
        echo "What to send!?"
        exit 1
    fi
    # Use the curl command to send the message
    curl -F "chat_id=$chatid" -F "photo=@$2" "https://api.telegram.org/bot$apitoken/sendphoto"
    exit 0
else
    # Check if the first argument is empty
    if [ -z "$1" ]; then
        echo "What to send!?"
        exit 1
    fi
fi

# Use the curl command to send the message
curl -s -X POST "https://api.telegram.org/bot$apitoken/sendMessage" -d chat_id=$chatid -d text="$1"
