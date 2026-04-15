#!/bin/bash

STATE_FILE="/tmp/waybar_bt_index"
if [ ! -f "$STATE_FILE" ]; then echo "0" > "$STATE_FILE"; fi

# Get list of connected devices with battery
DEVICES=$(bluetoothctl devices Connected | cut -d ' ' -f 2 | xargs -I {} bluetoothctl info {} | awk '
    /^Device/ {mac=$2; name=substr($0, index($0,$3))}
    /Battery Percentage/ {print mac "|" name "|" $4}
' | tr -d '()')

# If no devices with battery found, show generic icon
if [ -z "$DEVICES" ]; then
    echo '{"text": "", "tooltip": "No battery info available"}'
    exit 0
fi

CONF_COUNT=$(echo "$DEVICES" | wc -l)
INDEX=$(cat "$STATE_FILE")

if [ "$1" == "next" ]; then
    INDEX=$(( (INDEX + 1) % CONF_COUNT ))
    echo "$INDEX" > "$STATE_FILE"
fi

SELECTED=$(echo "$DEVICES" | sed -n "$((INDEX + 1))p")
NAME=$(echo "$SELECTED" | cut -d '|' -f 2)
BATT=$(echo "$SELECTED" | cut -d '|' -f 3)

# This sends the percentage as the main text and the device name as the hover tooltip
echo "{\"text\": \" $BATT%\", \"tooltip\": \"$NAME\"}"
