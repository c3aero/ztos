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

## Build and Installation

Follow the steps below to build the ZTOS kernel, create the initrd, and package everything for deployment. After the OS is built, use the provided documentation to configure network services and management containers.

### Prerequisites

- **iPXE** for network booting.
- **Docker** for containerized services.
- Access to **AWS**, **Equinix Metal**, or on-prem hardware.

### Quick Start

1. Clone the repository:

    ```bash
    git clone https://github.com/c3aero/ztos.git
    cd ztos
    ```

2. Build the ZTOS OS:

    Follow the instructions in the [Build Instructions](./docs/build-instructions.md) to build the kernel, create the initrd, and package the OS for iPXE booting or ISO creation.

3. Configure Docker and Containers:

    Once the OS is built, configure **Docker** and containerized services such as **BGP**, **WireGuard**, **MACsec**, and **GPU Offload**. Detailed setup instructions can be found in the [Container Setup Guide](./docs/container-setup.md).

4. Run the system setup script:

    ```bash
    ./scripts/setup-systemd.sh
    ```

    This script will configure Docker and set up services to start automatically.

5. Use Docker Compose to start all services:

    ```bash
    sudo systemctl start ztos-containers
    ```

## Documentation

- [Build Instructions](./docs/build-instructions.md): Step-by-step guide to building the ZTOS kernel, initrd, and OS.
- [Container Setup Guide](./docs/container-setup.md): Instructions to build and run the network service and management containers.
- [Network Configuration](./docs/network-config.md): Information on configuring BGP, WireGuard, MACsec, VXLAN, and more.
- [iPXE Boot Guide](./docs/ipxe-boot-guide.md): Guide for deploying ZTOS via iPXE in various environments like AWS, Equinix Metal, and on-prem hardware.
- [Monitoring API](./docs/monitoring-api.md): Documentation on how to use the monitoring API to check system and container health.

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements or bug fixes.

## License

This project is licensed for internal use by **C3Aero Group Inc.**. Redistribution or external use is prohibited.
