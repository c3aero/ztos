#!/bin/bash

# Function to test WireGuard connection
test_wireguard_connection() {
    echo "Running WireGuard Security Test..."

    # Ensure the WireGuard container is running
    docker ps | grep ztos-wireguard > /dev/null
    if [ $? -ne 0 ]; then
        echo "Error: WireGuard container is not running."
        exit 1
    fi

    # Run a simple connection check using ping (replace with real peer IP)
    PEER_IP="10.0.0.2"
    ping -c 4 $PEER_IP > /dev/null

    if [ $? -eq 0 ]; then
        echo "WireGuard Security Test Passed."
    else
        echo "WireGuard Security Test Failed. Unable to reach peer."
        exit 1
    fi
}

# Run the test
test_wireguard_connection

