#!/bin/sh

# Ask for the user password
# Script only works if sudo caches the password for a few minutes
sudo true

# Check for 1GB Memory
totalk=$(awk '/^MemTotal:/{print $2}' /proc/meminfo)
if [ "$totalk" -lt "1000000" ]; then echo "At least 1GB Memory is required!"; exit 1; fi

# Update the system
sudo apt-get update && sudo apt-get upgrade

#Wait Message
echo -e *********************************************************************
echo -e Some programs need to be downloaded from the interet.
echo -e This will take some time depending on your internet connection speed.
echo -e *********************************************************************
echo -e

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh