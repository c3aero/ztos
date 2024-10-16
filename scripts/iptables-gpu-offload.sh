#!/bin/bash

# Variables
INTERFACE="eth0"  # The interface to apply packet marking (modify as needed)
MARK_VALUE="0x1"  # Mark packets with a custom mark for GPU offload
CHAIN_NAME="GPU_OFFLOAD"  # Custom iptables chain for GPU processing

# Step 1: Create a new chain for GPU offload
echo "Creating custom chain for GPU offload..."
iptables -N $CHAIN_NAME

# Step 2: Mark the traffic for GPU offload
echo "Marking packets for GPU offload..."
iptables -A PREROUTING -t mangle -i $INTERFACE -j $CHAIN_NAME

# Example of marking packets based on source IP (modify as needed)
SRC_IP="192.168.1.100"
iptables -A $CHAIN_NAME -s $SRC_IP -j MARK --set-mark $MARK_VALUE

# Step 3: Send marked packets to a custom queue for GPU processing (via NFQUEUE)
# This assumes the GPU processing container will process packets from the NFQUEUE
echo "Sending marked packets to NFQUEUE for GPU processing..."
iptables -A $CHAIN_NAME -m mark --mark $MARK_VALUE -j NFQUEUE --queue-num 0

# Step 4: Set up iptables rules to allow normal traffic not marked for GPU offload
echo "Allowing normal traffic to proceed without GPU offload..."
iptables -A $CHAIN_NAME -j ACCEPT

# Step 5: Output current iptables rules for verification
echo "Displaying current iptables rules..."
iptables -L -v -t mangle

