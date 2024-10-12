#!/bin/bash

# Function to simulate packet input and capture output from the GPU offload container
test_gpu_offload() {
    echo "Running GPU Offload Test..."

    # Create a dummy packet for testing
    PACKET_DATA="Test packet data for GPU processing"

    # Run the GPU offload container and pass the packet data as an environment variable
    OUTPUT=$(docker run --rm --gpus all --network host \
        -e PACKET_DATA="$PACKET_DATA" \
        ztos-gpu-offload)

    # Check if the output has been processed
    if [[ "$OUTPUT" == *"Processed packet data"* ]]; then
        echo "GPU Offload Test Passed."
    else
        echo "GPU Offload Test Failed."
        exit 1
    fi
}

# Run the test
test_gpu_offload

