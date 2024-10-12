# ZTOS Architecture Overview

This document provides a high-level overview of the architecture of ZTOS, focusing on the core components, networking stack, and management interfaces (CLI, API, and Web interface). The system is designed to deliver secure, scalable, and flexible networking for Zero Trust environments.

---

## Core Components

ZTOS is built around key technologies that enable secure and scalable networking. These components include:

1. **BGP/L2EVPN (VRF & VNI Management)**: Used for dynamic routing and traffic segmentation across tenant networks.
2. **WireGuard**: Provides Layer 3 encryption to secure communication between nodes.
3. **VXLAN+MACsec**: VXLAN creates Layer 2 overlays for isolated tenant networks, and MACsec secures traffic at Layer 2.
4. **GPU Offload**: NVIDIA GPUs are used to accelerate packet processing tasks like encryption and filtering.

---

## Directory Structure

The repository is structured to provide clear separation of the core components, management interfaces, and testing:

	```bash
	├── api                  # API server and routes for programmatic control of ZTOS
	│   ├── routes
	│   │   ├── monitoring.js
	│   │   ├── network.js
	│   │   └── security.js
	│   └── server.js        # Main API server
	├── cli                  # Command Line Interface (CLI) commands for managing ZTOS
	│   └── commands
	│       ├── monitoring.sh
	│       ├── network.sh
	│       └── security.sh
	├── containers           # Container configurations for key network services
	│   ├── bgp
	│   ├── gpu-offload
	│   ├── macsec
	│   └── wireguard
	├── docs                 # Documentation
	├── web                  # Web interface for managing ZTOS via a browser
	│   ├── dashboard
	│   ├── network-config
	│   └── security
	├── tests                # Test scripts for verifying functionality and security
	├── ztos-config          # Configuration files for VRF, VNI, etc.


---

## Management Interfaces

ZTOS can be managed using multiple interfaces:

### 1. **Command Line Interface (CLI)**

The **CLI** allows power users to interact with ZTOS for detailed configuration and management tasks. Each command focuses on a specific aspect of the system, such as network configuration, security status, and monitoring.

- **Network Configuration**: Configure BGP, WireGuard, and VXLAN.
- **Security Management**: Enable/disable MACsec, manage WireGuard peers.
- **Monitoring**: Pull real-time logs and performance metrics.

Example usage:
	```bash
	ztos network configure --bgp --peer 10.1.1.1 --as 64512
	ztos security status
	ztos monitoring logs


### 2. **RESTful API**

The **API** provides programmatic control of ZTOS and can be used for automation, monitoring, and integration with other systems (e.g., SIEM, SOC).

- **Network API**: Configure network services like BGP, VXLAN, and WireGuard.
- **Security API**: Manage encryption services such as MACsec and WireGuard.
- **Monitoring API**: Retrieve system metrics and logs.

Example API routes:
	```bash
	POST /api/v1/network/configure   # Configure BGP, VXLAN, etc.
	GET /api/v1/security/status      # Get the current security status (MACsec, WireGuard)
	GET /api/v1/monitoring/logs      # Retrieve system logs


### 3. **Web Interface**

The **Web Interface** is designed for users who prefer a graphical interface. It allows for easy configuration and monitoring of ZTOS through a browser, and integrates with performance monitoring tools like Grafana.

- **Dashboard**: Overview of network health and performance metrics.
- **Network Configuration**: GUI for setting up BGP peers, WireGuard, and VXLAN tunnels.
- **Security Visualization**: Real-time view of encryption status (MACsec, WireGuard) and key management.

---

## Network Stack Overview

The ZTOS network stack is built around the following core components:

### 1. **BGP/L2EVPN (VRF & VNI Management)**
- BGP handles dynamic Layer 3 routing between nodes.
- EVPN enables Layer 2 services over the Layer 3 network.
- VRFs and VNIs are used for tenant isolation and traffic segmentation.

### 2. **WireGuard (Layer 3 Encryption)**
- WireGuard provides Layer 3 encryption for secure communication between nodes.
- Encrypted traffic traverses the network over VXLAN tunnels.

### 3. **VXLAN + MACsec (Layer 2 Overlay + Encryption)**
- VXLAN creates Layer 2 overlays, allowing isolated tenant networks over a shared Layer 3 infrastructure.
- MACsec provides Layer 2 encryption, securing traffic between leaf nodes in the network.

### 4. **GPU Offload for Network Processing**
- NVIDIA GPUs are used to accelerate network processing tasks such as packet encryption, deep packet inspection, and filtering.
- GPU offloading helps maintain high performance and low latency for encryption and security-related tasks.

---

## Testing and Security Validation

### 1. **Security Tests**
- **WireGuard**: `wireguard-test.sh` ensures that WireGuard peers are configured and functioning securely.
- **MACsec**: `macsec-test.sh` verifies MACsec encryption between nodes.

### 2. **Network Tests**
- **VXLAN**: `vxlan-test.sh` tests the functionality of VXLAN tunnels and traffic flow across the network.
- **GPU Offload**: `gpu-offload-test.sh` and `gpu-offload-benchmark.sh` verify the functionality and performance of GPU-accelerated network processing.

---

## Conclusion

ZTOS combines traditional networking technologies like BGP, VXLAN, and MACsec with modern tools like WireGuard and GPU offloading to create a secure, scalable, and high-performance network stack. The system can be managed via CLI, API, or Web Interface, making it accessible to a wide range of users and industries, including Aerospace, Defense, Finance, and Government.
