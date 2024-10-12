# ZTOS Container Setup Guide

This guide provides detailed instructions on how to set up and run the core network services in ZTOS using Docker containers.

---

## 1. BGP Service

**BGP** is used for routing traffic between spine and leaf nodes. We’ll containerize the BGP service using FRR (Free Range Routing).

### Steps:

1. Build the BGP container:
	cd containers/bgp
	docker build -t ztos-bgp . 

2. Run the BGP container:
	docker run -d --name ztos-bgp -v $(pwd)/bgp.conf:/etc/frr/frr.conf ztos-bgp 

3. Verify the BGP service is running:
	docker exec -it ztos-bgp vtysh -c "show ip bgp summary" 

4. (Optional) You can customize the `bgp.conf` file in the `containers/bgp/` directory to match your environment.

---

## 2. WireGuard Service

**WireGuard** is used to encrypt Layer 3 traffic. Follow the steps below to containerize the WireGuard service.

### Steps:

1. Build the WireGuard container:
	cd containers/wireguard
	docker build -t ztos-wireguard . 

2. Run the WireGuard container:
	docker run -d --name ztos-wireguard -v $(pwd)/wg0.conf:/etc/wireguard/wg0.conf ztos-wireguard 

3. Verify the WireGuard service is running:
	docker exec -it ztos-wireguard wg show 

4. (Optional) You can update the `wg0.conf` file in the `containers/wireguard/` directory for different peer configurations.

---

## 3. MACsec Service

**MACsec** secures Layer 2 traffic between nodes. We’ll containerize the MACsec service for secure communication between leaf and spine nodes.

### Steps:

1. Build the MACsec container:
	cd containers/macsec
	docker build -t ztos-macsec . 

2. Run the MACsec container:
	docker run -d --name ztos-macsec -v $(pwd)/macsec.conf:/etc/macsec.conf ztos-macsec 

3. Verify the MACsec service is running:
	docker exec -it ztos-macsec ip macsec show 

4. (Optional) Update the `macsec.conf` file in the `containers/macsec/` directory to customize the MACsec configuration for your network.

---

## 4. GPU Offload Service

**GPU Offload** is used to accelerate network processing tasks like encryption, filtering, and DPI using NVIDIA GPUs. The GPU offload container can be built and run as follows.

### Steps:

1. Build the GPU offload container:
	cd containers/gpu-offload
	docker build -t ztos-gpu-offload . 

2. Run the GPU offload container:
	docker run --gpus all --network host --cap-add=NET_ADMIN ztos-gpu-offload 

3. Configure iptables to mark packets for GPU processing:
	./scripts/iptables-gpu-offload.sh 

4. Verify that packets are being processed by the GPU container by monitoring traffic:
	docker logs ztos-gpu-offload 

---

## 5. Container Orchestration with Docker Compose

You can use Docker Compose to orchestrate multiple ZTOS services such as BGP, WireGuard, MACsec, and GPU Offload. This simplifies the deployment and integration of different services.

### Steps:

1. Build the individual containers (BGP, WireGuard, MACsec, GPU Offload) as described in the earlier sections.
2. Create a `docker-compose.yml` file with the following content:
   
	version: '3'
	services:
	  bgp:
		image: ztos-bgp
		networks:
		  - ztos-network
		  
		  wireguard:
		  image: ztos-wireguard
		  networks:
		  - ztos-network
		  cap_add:
		  - NET_ADMIN
		  environment:
		  - PEER_PUBLIC_KEY=your-peer-key
		  
		  macsec:
		  image: ztos-macsec
		  networks:
		  - ztos-network
		  cap_add:
		  - NET_ADMIN
		  
		  gpu-offload:
		  image: ztos-gpu-offload
		  networks:
		  - ztos-network
		  gpus: all
		  environment:
		  - PACKET_DATA="Test packet for GPU processing"
		  
		  api:
		  image: ztos-api
		  networks:
		  - ztos-network
		  ports:
		  - "3000:3000"
		  
		  web:
		  image: ztos-web
		  networks:
		  - ztos-network
		  ports:
		  - "8080:8080"
		  
		  networks:
		  ztos-network:
		  driver: bridge

3. Use `docker-compose up` to start all services and test their interoperability.
