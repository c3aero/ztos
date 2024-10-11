#
# Dockerfile for BGP container using FRR
FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    frr frr-pythontools iproute2 iputils-ping \
    && rm -rf /var/lib/apt/lists/*

COPY ./bgp.conf /etc/frr/frr.conf

CMD ["frr"]

