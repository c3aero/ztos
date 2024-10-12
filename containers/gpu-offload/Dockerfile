# Use the official CUDA image as the base
FROM nvidia/cuda:11.0-base

# Install necessary libraries
RUN apt-get update && apt-get install -y \
    iptables \
    libssl-dev \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copy the CUDA-based packet processing code into the container
COPY packet_processor.cu /usr/src/packet_processor.cu

# Set the working directory
WORKDIR /usr/src/

# Compile the packet processing application
RUN /usr/local/cuda/bin/nvcc -o packet_processor packet_processor.cu

# Set the entrypoint to run the packet processor
ENTRYPOINT ["./packet_processor"]
