#!/bin/sh

# Ask for the user password
# Script only works if sudo caches the password for a few minutes
sudo true

# Update the system
sudo apt-get update && sudo apt-get upgrade

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh