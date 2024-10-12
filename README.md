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

## Installation and Usage

### Prerequisites

- **iPXE** for network booting.
- **Docker** or **Podman** for containerized services.
- Access to **AWS**, **Equinix Metal**, or on-prem hardware.

### Quick Start

1. Clone the repository:

    ```bash
    git clone https://github.com/c3aero/ztos.git
    cd ztos
    ```

2. Build the network service containers:

    ```bash
    # Build BGP container
    cd containers/bgp
    docker build -t ztos-bgp .

    # Build WireGuard container
    cd containers/wireguard
    docker build -t ztos-wireguard .

    # Build MACsec container
    cd containers/macsec
    docker build -t ztos-macsec .

    # Build GPU Offload container
    cd containers/gpu-offload
    docker build -t ztos-gpu-offload .
    ```

3. Build the management containers:

    ```bash
    # Build API container
    cd containers/api
    docker build -t ztos-api .

    # Build Web Interface container
    cd containers/web
    docker build -t ztos-web .

    # Build CLI container
    cd containers/cli
    docker build -t ztos-cli .
    ```

4. Run the system setup script to enable Docker services and start the containers:

    ```bash
    ./scripts/setup-systemd.sh
    ```

5. Use Docker Compose to start all services:

    ```bash
    sudo systemctl start ztos-containers
    ```

6. Access the management interfaces:

    - **API**: `http://localhost:3000`
    - **Web Interface**: `http://localhost:8080`
    - **CLI**: Connect using Docker CLI or bash shell.

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
