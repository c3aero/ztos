# Dockerfile for MACsec container (Placeholder)
FROM ubuntu:20.04

RUN apt-get update && apt-get install -y iproute2

# Placeholder for configuration
COPY ./macsec.conf /etc/macsec.conf

CMD ["ip", "macsec", "add", "link", "eth0", "macsec0", "type", "macsec"]

