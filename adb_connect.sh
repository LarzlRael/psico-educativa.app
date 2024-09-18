#!/bin/bash
# Don't forget to grant execute permission to the file
# chmod +x adb_connect.sh

# Check if an IP address was provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 YOUR_IP"
    exit 1
fi

# Assign the first argument to the variable IP
IP=$1

# Kill the ADB server
adb kill-server

# Switch ADB to TCP/IP mode on port 5555
adb tcpip 5555

# Connect to the provided IP address
adb connect "$IP:5555"
