#!/bin/bash

# Step 1: Ensure Docker is running (installed in the rootfs)
sudo systemctl start docker

# Step 2: Build or pull containers
echo "Building containers..."
cd /path/to/ztos/containers
for container in bgp wireguard macsec gpu-offload api web cli; do
    echo "Building $container container..."
    cd $container
    docker build -t ztos-$container .
    cd ..
done

# Step 3: Set up Systemd services
echo "Configuring Systemd services for Docker and containers..."
sudo cp /path/to/ztos/systemd/docker.service /etc/systemd/system/
sudo cp /path/to/ztos/systemd/ztos-containers.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable ztos-containers

# Step 4: Start the containers using Docker Compose
echo "Starting ZTOS containers..."
sudo systemctl start ztos-containers

# Step 5: Provide access URL
echo "ZTOS is up and running. You can access the Web Interface at http://localhost:8080"

