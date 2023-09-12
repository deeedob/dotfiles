#!/bin/bash

# Curl telegram messages sent to a bot
if [ -z "$1" ]; then
    echo "Usage: telecurl.sh <bot_token>"
    exit 1
fi

curl "https://api.telegram.org/bot$1/getUpdates" | jq --color-output
