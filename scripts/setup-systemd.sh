#!/bin/bash

# Copy systemd service files to the system folder
sudo cp systemd/docker.service /etc/systemd/system/docker.service
sudo cp systemd/ztos-containers.service /etc/systemd/system/ztos-containers.service

# Reload systemd daemon to pick up new services
sudo systemctl daemon-reload

# Enable Docker to start at boot
sudo systemctl enable docker

# Enable ZTOS containers to start at boot
sudo systemctl enable ztos-containers

# Start Docker immediately
sudo systemctl start docker

# Start ZTOS containers immediately
sudo systemctl start ztos-containers

echo "Docker and ZTOS containers services have been set up and started!"

