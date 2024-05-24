#!/bin/bash

# Check if Docker is already installed
if command -v docker &>/dev/null; then
    echo "Docker is already installed."
else
    echo "Installing Docker..."
    # Update the apt package index and install packages to allow apt to use a repository over HTTPS
    sudo apt-get update
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    # Add Docker's official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Add Docker repository
    echo \
        "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker Engine
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    # Add current user to the docker group to run Docker commands without sudo
    sudo usermod -aG docker $USER

    echo "Docker installation completed. Please log out and log back in for the changes to take effect."
fi

# Check if Docker Compose is already installed
if command -v docker-compose &>/dev/null; then
    echo "Docker Compose is already installed."
else
    echo "Installing Docker Compose..."
    # Download the latest stable release of Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # Apply executable permissions to the Docker Compose binary
    sudo chmod +x /usr/local/bin/docker-compose

    echo "Docker Compose installation completed."
fi

# Display Docker and Docker Compose versions
echo "Docker version:"
docker --version
echo "Docker Compose version:"
docker-compose --version

# # EXECUTION
# # Open a terminal, find install_docker.sh, and then make it executable:

# $ chmod +x install_docker.sh
# # You can then run the script with sudo permissions:

# $ sudo ./install_docker.sh