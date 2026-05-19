#!/bin/bash
# Temporary Fallback using wttr.in
# 'format=%t' returns just the temperature (e.g., +31°C)
TEMP=$(curl -s "wttr.in/Hyderabad?format=%t" | tr -d '+')

if [[ -z "$TEMP" || "$TEMP" == *"Unknown"* || "$TEMP" == *"Error"* ]]; then
    echo "69°C"
else
    echo "$TEMP"
fi
