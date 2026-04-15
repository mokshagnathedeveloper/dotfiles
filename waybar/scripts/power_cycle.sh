#!/bin/bash

# Get current profile
CURRENT=$(powerprofilesctl get)

# Cycle logic
case $CURRENT in
    performance)
        powerprofilesctl set balanced
        ;;
    balanced)
        powerprofilesctl set power-saver
        ;;
    power-saver)
        powerprofilesctl set performance
        ;;
    *)
        powerprofilesctl set balanced
        ;;
esac

# Send signal to waybar to update instantly (using SIGRTMIN+8)
pkill -RTMIN+8 waybar