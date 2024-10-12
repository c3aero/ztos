FROM debian:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y bash curl

# Copy CLI scripts into the container
COPY commands /usr/local/bin/

# Make the scripts executable
RUN chmod +x /usr/local/bin/*

# Set the entry point
ENTRYPOINT ["/bin/bash"]

