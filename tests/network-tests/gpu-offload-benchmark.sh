#!/bin/bash

# Number of packets to process
NUM_PACKETS=100000

# Function to benchmark GPU offload
benchmark_gpu_offload() {
    echo "Running GPU Offload Benchmark..."

    # Start time
    START_TIME=$(date +%s)

    # Simulate large-scale packet processing
    for i in $(seq 1 $NUM_PACKETS); do
        docker run --rm --gpus all --network host \
            ztos-gpu-offload > /dev/null
    done

    # End time
    END_TIME=$(date +%s)
    ELAPSED_TIME=$(($END_TIME - $START_TIME))

    echo "Processed $NUM_PACKETS packets in $ELAPSED_TIME seconds."
}

# Run the benchmark
benchmark_gpu_offload

