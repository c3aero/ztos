# Dockerfile for WireGuard container (Placeholder)
FROM ubuntu:20.04

RUN apt-get update && apt-get install -y wireguard iproute2

# Placeholder for configuration
COPY ./wg0.conf /etc/wireguard/wg0.conf

CMD ["wg-quick", "up", "/etc/wireguard/wg0.conf"]

