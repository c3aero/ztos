# ZTOS Architecture Overview

This document provides a high-level overview of the architecture of ZTOS, focusing on the core components, the networking stack, and how the system integrates key technologies such as BGP, VXLAN, MACsec, WireGuard, and GPU offload for accelerated network processing.

---

## Core Components

ZTOS is built around a core set of technologies that enable secure, scalable, and flexible networking for Zero Trust environments.

### Key Features:

1. **BGP/L2EVPN (VRF & VNI Management)**: BGP is used to manage dynamic routing between leaf and spine nodes, with EVPN extensions enabling Layer 2 services over a Layer 3 network. Each tenant is isolated using VRFs and VNIs.
2. **WireGuard (Layer 3 Encryption)**: WireGuard is used to encrypt Layer 3 traffic between nodes, securing communication across the network.
3. **VXLAN+MACsec (Layer 2 Overlay and Encryption)**: VXLAN enables Layer 2 overlays across a Layer 3 network, while MACsec provides encryption for Layer 2 traffic between leaf nodes.
4. **GPU Offload for Network Processing**: NVIDIA GPUs are used to accelerate packet processing, such as encryption and filtering, via Docker containers.

---

## Network Architecture

ZTOS's network architecture is designed to provide a high level of security and scalability, leveraging a mix of routing, encryption, and overlay technologies.

### Network Layers:

1. **BGP/L2EVPN (VRF & VNI Management)** - Layer 3 Spine and VRF Gateway:
   - BGP handles dynamic routing between the **Spine** and **Leaf** nodes.
   - EVPN is used for extending Layer 2 services over the Layer 3 network.
   - VRFs are employed to ensure tenant isolation, with VXLAN VNIs mapped to VLANs.

2. **WireGuard (Layer 3 Underlay and Encryption)** - Layer 3 Spine to Leaf Encryption:
   - WireGuard is used to encrypt Layer 3 traffic between nodes (spine and leaf).
   - This layer ensures secure communication, encrypting data in transit across the network.

3. **VXLAN + MACsec (Layer 2 Overlay and Encryption)** - Layer 2 Leaf to Leaf:
   - VXLAN creates a Layer 2 overlay on top of the Layer 3 underlay, enabling isolated Layer 2 networks for each tenant.
   - MACsec encrypts Layer 2 traffic, ensuring that the VXLAN encapsulated traffic remains secure as it traverses between nodes.

4. **Bridge** - Layer 2 Customer Network and L3 Customer VRF:
   - Traffic from the customer's Layer 2 network is bridged into the ZTOS network, with the bridge handling traffic between the customer’s Layer 2 network and their respective VRF.

---

## GPU Offload for Pre/Postrouting Tasks

ZTOS introduces GPU offload for accelerating complex network processing tasks such as encryption, deep packet inspection (DPI), and filtering.

### GPU Offload Integration

1. **Pre-routing Offload**:
   - Packets are marked in the pre-routing chain for processing by the GPU offload container.
   - The container uses **CUDA** to handle encryption and filtering tasks at scale, improving performance for high-throughput environments.

2. **Post-routing Offload**:
   - Post-routing tasks like Network Address Translation (NAT) and packet re-encryption are offloaded to the GPU, enhancing efficiency in traffic forwarding and processing.

3. **GPU Offload Pipeline**:
   ```bash 
   iptables -t mangle -A PREROUTING -j MARK --set-mark 1
   iptables -t nat -A POSTROUTING -m mark --mark 1 -j SNAT --to-source <GPU-processed-IP>
   

---

## Example Flow

1. **Inbound Traffic**:
   - Traffic enters the network and is first handled by **WireGuard**, which decrypts the Layer 3 encrypted traffic.
   - Traffic is then routed through the **BGP** routing system, where routing decisions are made based on the destination VRF.

2. **VXLAN and MACsec**:
   - The decrypted traffic is encapsulated within a **VXLAN** tunnel to provide Layer 2 services across the Layer 3 backbone.
   - **MACsec** encrypts the VXLAN traffic for secure traversal across the network.

3. **GPU Offload**:
   - Depending on the **iptables** rules, packets can be offloaded to the GPU for processing, enhancing the efficiency of encryption, filtering, or deep packet inspection.

---

## Deployment and Scalability

ZTOS is designed to scale across cloud, hybrid, and on-premises environments. By using containerized network services and GPU acceleration, ZTOS can dynamically adjust to the needs of different environments.

### Example Deployment Models:

1. **Cloud Deployment (AWS, Equinix Metal)**:
   - ZTOS is deployed using iPXE to provision bare-metal or virtual machines in the cloud. The GPU offload containers can run in cloud environments equipped with GPUs.

2. **On-Premises Deployment**:
   - ZTOS can be deployed on physical hardware, with iPXE used to boot into ZTOS. The system can leverage on-prem GPUs for offload tasks.

---

## Conclusion

ZTOS combines traditional network technologies like BGP and VXLAN with modern security practices like WireGuard and MACsec, while using cutting-edge GPU acceleration for packet processing. This architecture allows ZTOS to provide a secure, scalable, and high-performance network for Zero Trust environments.
