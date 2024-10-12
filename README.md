# ZTOS (Zero Trust Operating System)

**ZTOS** is a secure, scalable, and flexible operating system designed to implement **Zero Trust Networking** principles. It is deployable across cloud environments like **AWS**, hybrid infrastructures like **Equinix Metal**, and private on-premises hardware. ZTOS ensures multi-layer encryption, dynamic routing, and secure containerized network services for industries like Aerospace, Defense, Finance, and Government.

## Key Features

- **iPXE Booting**: Zero-touch deployment into cloud or bare-metal environments.
- **Custom Linux Distribution**: Networking-focused OS, optimized for routing and security services.
- **Multi-Layer Encryption**: Layer 2 encryption with **MACsec** and Layer 3 encryption with **WireGuard**.
- **Containerized Network Services**: Modular and scalable services such as **BGP**, **WireGuard**, and **MACsec**.
- **GPU Offload for Packet Processing**: Use NVIDIA GPUs to accelerate pre-routing and post-routing network tasks such as encryption and filtering.
- **Zero Trust Networking**: Continuous authentication and least-privilege access to all network resources.
- **Multi-Tenant Support**: Fully isolated VRFs and VXLANs for traffic segmentation.

## Project Status

ZTOS is currently under active development. The repository includes the initial architecture design, boot process configurations, and containerized network services. GPU offload capabilities have been introduced for optimizing network packet processing.

## Installation and Usage

### Prerequisites

- **iPXE** for network booting
- **Docker** or **Podman** for containerized services
- Access to **AWS**, **Equinix Metal**, or on-prem hardware
- **NVIDIA GPU and CUDA Toolkit** for GPU offload

### Quick Start

1. Clone the repository:

   git clone https://github.com/c3aero/ztos.git
   cd ztos

2. Build the ZTOS kernel:

   Follow the instructions in **`docs/build-instructions.md`** to build the ZTOS kernel, create the initrd, and prepare the system for deployment.

3. Set up GPU offload:

   - Build the Docker container for GPU offload:
     ```bash
     cd containers/gpu-offload
     docker build -t ztos-gpu-offload .
     ```

   - Configure iptables to mark packets for GPU processing:
     ```bash
     ./scripts/iptables-gpu-offload.sh
     ```

4. Boot into ZTOS:

   Use iPXE to boot into ZTOS in your desired environment. Detailed instructions are available in **`docs/ipxe-boot-guide.md`** for AWS, Equinix Metal, and on-prem hardware.
