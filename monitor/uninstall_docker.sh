#!/bin/bash

# Uninstall Docker
echo "Uninstalling Docker..."
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io
sudo rm -rf /var/lib/docker /etc/docker
sudo groupdel docker
sudo rm -rf /usr/local/bin/docker-compose
echo "Docker uninstallation completed."

# Uninstall Docker Compose
echo "Uninstalling Docker Compose..."
sudo rm -rf /usr/local/bin/docker-compose
echo "Docker Compose uninstallation completed."

# $ chmod +x uninstall_docker.sh
# # You can then run the script with sudo permissions:

# $ sudo ./uninstall_docker.sh