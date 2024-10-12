# ZTOS (Zero Trust Operating System)

**ZTOS** is a secure, scalable, and flexible operating system designed to implement **Zero Trust Networking** principles. It is deployable across cloud environments like **AWS**, hybrid infrastructures like **Equinix Metal**, and private on-premises hardware. ZTOS ensures multi-layer encryption, dynamic routing, and secure containerized network services for industries like Aerospace, Defense, Finance, and Government.

## Key Features

- **iPXE Booting**: Zero-touch deployment into cloud or bare-metal environments.
- **Custom Linux Distribution**: Networking-focused OS, optimized for routing and security services.
- **Multi-Layer Encryption**: Layer 2 encryption with **MACsec** and Layer 3 encryption with **WireGuard**.
- **Containerized Network Services**: Modular and scalable services such as **BGP**, **WireGuard**, and **MACsec**.
- **GPU Offload**: Uses NVIDIA GPUs to accelerate network processing tasks like encryption and filtering.
- **Zero Trust Networking**: Continuous authentication and least-privilege access to all network resources.
- **Multi-Tenant Support**: Fully isolated VRFs and VXLANs for traffic segmentation.
- **Comprehensive Management**: API, Web Interface, and CLI management containers.
- **Monitoring and System Health**: Monitor system and container health via an API for real-time stats.

## Project Status

ZTOS is currently under active development. The repository includes the initial architecture design, boot process configurations, and containerized network services for deployment.

## Installation and Build Process

Follow the steps below to build the ZTOS kernel, create the initrd, package the root filesystem, and install Docker to orchestrate the services. After the OS is built, use the provided documentation to configure network services and management containers.

### Prerequisites

- **Debootstrap** for root filesystem creation.
- **iPXE** for network booting, or tools to create an ISO for booting.
- **Docker** or **Podman** for containerized services.
- Access to **AWS**, **Equinix Metal**, or on-prem hardware for deployment.

### Quick Start

1. **Clone the repository**:
    ```bash
    git clone https://github.com/c3aero/ztos.git
    cd ztos
    ```

2. **Build the kernel, initrd, and root filesystem**:
    - Run the **build script** to compile the kernel, generate the initrd, and create the root filesystem:
    ```bash
    cd build
    ./build-rootfs.sh
    ```
    - This will generate the **kernel**, **initrd**, and **root filesystem** in the `output/` directory.

3. **Boot the ZTOS Host**:
    - Use **iPXE** or an ISO to boot the system with the generated kernel, initrd, and root filesystem. Refer to `ipxe-boot-guide.md` for instructions.

4. **Set up Docker and services on the ZTOS Host**:
    - Once the system is booted, run the **host setup script** to install Docker, build the containers, and configure services:
    ```bash
    cd /path/to/ztos
    ./scripts/ztos-host-setup.sh
    ```

5. **Access the Web Interface**:
    - Once Docker and the containers are running, access the ZTOS Web Interface at `http://localhost:8080`.

## Booting via iPXE or ISO

Refer to the **`ipxe-boot-guide.md`** document for step-by-step instructions on booting ZTOS using iPXE or an ISO. This document covers:
- **AWS** deployment with iPXE.
- **Equinix Metal** deployment.
- **On-prem hardware** boot process.

## Network Configuration

ZTOS includes network services such as **BGP**, **WireGuard**, **MACsec**, and **VXLAN**. Refer to **`network-config.md`** for detailed instructions on configuring the networking stack.

## Monitoring and Health Checks

ZTOS includes a monitoring API that provides system information, container health, and Docker service status.

### Available Monitoring Endpoints

- **System Information**: `/api/monitoring/system-info`
- **Container Stats**: `/api/monitoring/container-stats`
- **Container Health**: `/api/monitoring/container-health/:containerId`
- **Docker Status**: `/api/monitoring/docker-status`

Use these endpoints to retrieve real-time information on the state of your ZTOS system and containers.

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements or bug fixes.

## License

This project is licensed for internal use by **C3Aero Group Inc.**. Redistribution or external use is prohibited.
