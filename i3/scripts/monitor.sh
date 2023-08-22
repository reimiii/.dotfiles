#!/bin/bash

# Get the HDMI status using the command
HDMI_STATUS=$(xrandr --query | grep "HDMI-A-0" | awk '{print $2}')

# Check if HDMI is connected
if [ "$HDMI_STATUS" = "connected" ]; then
    xrandr --output eDP --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-0 --mode 1366x768 --pos 1920x0 --rotate normal
fi