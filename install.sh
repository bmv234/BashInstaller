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
echo " "
echo "*********************************************************************"
echo "Some programs need to be downloaded from the internet."
echo "This will take some time depending on your internet connection speed."
echo "*********************************************************************"
echo " "

# Install Docker
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Add User to Docker
sudo usermod -aG docker $USERNAME

# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install InfluxDB Docker Container
sudo docker run -d -p 8086:8086 influxdb

#Open new terminal
#gnome-terminal

# Install Grafana Docker Container
sudo docker run --name=grafana -d -p 3000:3000 grafana/grafana