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

# Check to see if docker-ce package is already installed, if not install docker-ce
if dpkg -s "docker-ce" >/dev/null 2>&1; then
    echo " "
    echo "*********************************************************************"
    echo "docker-ce is installed."
    echo "*********************************************************************"
    echo " "
else
    sudo curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
fi

# Add User to Docker (Test to see if works, require a logout and log back in)
sudo usermod -aG docker $USER

# Check to see if docker-compose is already installed, if not install docker-compose
if [ -f /usr/local/bin/docker-compose ]; then
    echo " "
    echo "*********************************************************************"
    echo "docker-compose is installed."
    echo "*********************************************************************"
    echo " "
else
    sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Install and Run InfluxDB Docker Container
sudo docker run --name=influxdb -d -p 8086:8086 unless-stopped influxdb

#Open new terminal
#gnome-terminal

# Install and Run Grafana Docker Container
sudo docker run --name=grafana -d -p 3000:3000 unless-stopped grafana/grafana

# Make Mosquitto Configuration File
mkdir -p ./mosquitto/config/ && touch ./mosquitto/config/mosquitto.conf
sudo chmod a+rwx ./mosquitto/config/mosquitto.conf

echo "persistence true" > ./mosquitto/config/mosquitto.conf
echo "persistence_location /mosquitto/data/" >> ./mosquitto/config/mosquitto.conf
echo "log_dest file /mosquitto/log/mosquitto.log" >> ./mosquitto/config/mosquitto.conf


# Install and Run Mosquitto Docker Container
docker run --name=mosquitto -it -p 1883:1883 -p 9001:9001 -v mosquitto.conf:$(pwd)/mosquitto/config/mosquitto.conf unless-stopped eclipse-mosquitto
