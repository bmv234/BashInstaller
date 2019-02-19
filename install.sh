#!/bin/sh

# Ask for the user password
# Script only works if sudo caches the password for a few minutes
sudo true
# Update the system
sudo apt-get update && sudo apt-get upgrade
