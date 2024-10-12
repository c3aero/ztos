# ZTOS Container Setup Guide

This guide provides detailed instructions on how to set up and run the core network services in ZTOS using Docker containers.

---

## 1. BGP Service

**BGP** is used for routing traffic between spine and leaf nodes. We’ll containerize the BGP service using FRR (Free Range Routing).

### Steps:

1. Build the BGP container:
	```bash 
	cd containers/bgp
docker build -t ztos-bgp . 

2. Run the BGP container:
	```bash 
	docker run -d --name ztos-bgp -v $(pwd)/bgp.conf:/etc/frr/frr.conf ztos-bgp 

3. Verify the BGP service is running:
	```bash 
	docker exec -it ztos-bgp vtysh -c "show ip bgp summary" 

4. (Optional) You can customize the `bgp.conf` file in the `containers/bgp/` directory to match your environment.

---

## 2. WireGuard Service

**WireGuard** is used to encrypt Layer 3 traffic. Follow the steps below to containerize the WireGuard service.

### Steps:

1. Build the WireGuard container:
	```bash 
	cd containers/wireguard
docker build -t ztos-wireguard . 

2. Run the WireGuard container:
	```bash 
	docker run -d --name ztos-wireguard -v $(pwd)/wg0.conf:/etc/wireguard/wg0.conf ztos-wireguard 

3. Verify the WireGuard service is running:
	```bash 
	docker exec -it ztos-wireguard wg show 

4. (Optional) You can update the `wg0.conf` file in the `containers/wireguard/` directory for different peer configurations.

---

## 3. MACsec Service

**MACsec** secures Layer 2 traffic between nodes. We’ll containerize the MACsec service for secure communication between leaf and spine nodes.

### Steps:

1. Build the MACsec container:
	```bash 
	cd containers/macsec
docker build -t ztos-macsec . 

2. Run the MACsec container:
	```bash 
	docker run -d --name ztos-macsec -v $(pwd)/macsec.conf:/etc/macsec.conf ztos-macsec 

3. Verify the MACsec service is running:
	```bash 
	docker exec -it ztos-macsec ip macsec show 

4. (Optional) Update the `macsec.conf` file in the `containers/macsec/` directory to customize the MACsec configuration for your network.

---

## 4. VXLAN Service (Optional)

While VXLAN can be configured directly on the host machine, you may also choose to containerize VXLAN services.

### Steps:

1. Build the VXLAN container:
	```bash
	cd containers/vxlan
	docker build -t ztos-vxlan . 

2. Run the VXLAN container:
	```bash 
	docker run -d --name ztos-vxlan -v $(pwd)/vxlan.conf:/etc/vxlan.conf ztos-vxlan 

3. Verify the VXLAN service is running:
	```bash 
	docker exec -it ztos-vxlan cat /etc/vxlan.conf 

---

## 5. GPU Offload Service

**GPU Offload** is used to accelerate network processing tasks like encryption, filtering, and DPI using NVIDIA GPUs. The GPU offload container can be built and run as follows.

### Steps:

1. Build the GPU offload container:
	```bash 
	cd containers/gpu-offload
	docker build -t ztos-gpu-offload . 

2. Run the GPU offload container:
	```bash 
	docker run --gpus all --network host --cap-add=NET_ADMIN ztos-gpu-offload 

3. Configure iptables to mark packets for GPU processing:
	```bash 
	./scripts/iptables-gpu-offload.sh 

4. Verify that packets are being processed by the GPU container by monitoring traffic:
	```bash 
	docker logs ztos-gpu-offload 

---

## Conclusion

This guide outlines how to set up and run the core networking services in ZTOS using Docker containers. Each service (BGP, WireGuard, MACsec, VXLAN, GPU Offload) is containerized for easy deployment, portability, and scalability. You can modify each configuration file (`bgp.conf`, `wg0.conf`, `macsec.conf`, `vxlan.conf`) as needed to suit your specific network environment.
