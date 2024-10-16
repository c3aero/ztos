# ZTOS (Zero Trust Operating System)

**ZTOS** is a secure, scalable, and flexible operating system designed to implement **Zero Trust Networking** principles. It is deployable across cloud environments like **AWS**, hybrid infrastructures like **Equinix Metal**, and private on-premises hardware. ZTOS ensures multi-layer encryption, dynamic routing, and secure containerized network services for industries such as Aerospace, Defense, Finance, and Government.

## Key Features

- **Zero Trust Networking**: Continuous authentication, least-privilege access, and end-to-end encryption for all services.
- **iPXE Booting**: Zero-touch deployment into cloud or bare-metal environments.
- **Custom Linux Distribution**: Networking-focused OS, optimized for routing and security services.
- **Multi-Layer Encryption**: Layer 2 encryption with **MACsec** and Layer 3 encryption with **WireGuard**.
- **GPU Offloading**: Leverages **NVIDIA GPUs** for accelerating network processing tasks like encryption and deep packet inspection.
- **Containerized Services**: Modular and scalable services, including **BGP**, **WireGuard**, **MACsec**, and **API**.
- **Real-Time Monitoring**: Integrated **Prometheus** and **Grafana** dashboards for system and container metrics.
- **Centralized Logging**: Aggregated logs using **Fluentd** or **Elasticsearch** for all containerized services.

## Getting Started

### Prerequisites

- **iPXE** for network booting
- **Docker** and **Docker Compose** for containerized services
- Access to **AWS**, **Equinix Metal**, or on-prem hardware
- **NVIDIA CUDA**-enabled GPUs for GPU offload functionality

### Build and Installation

ZTOS provides a fully automated build process to generate the root filesystem, kernel, and containers. Follow these steps to build and run ZTOS:

1. **Clone the repository**:
```
git clone https://github.com/c3aero/ztos.git
cd ztos
```

2. **Build the ZTOS system**:
   Run the build script to compile the kernel, create the root filesystem, and prepare the environment.
```
./build/build.sh
```

3. **Prepare the iPXE Boot Configuration**:
   If you are deploying to AWS, Equinix Metal, or on-prem hardware, modify the appropriate `ipxe` configuration file in `/ipxe/configs/`. Example for AWS:
```
cp ipxe/configs/aws.ipxe /boot/
```

4. **Configure and Run Containers**:
   Use **Docker Compose** to run core ZTOS services like BGP, MACsec, WireGuard, and the Web UI.
```
docker-compose up
```

### Key Components

#### **Core Containers**

- **API Container** (`/containers/api`):
  Manages all API calls for monitoring, networking, and security services. Exposes endpoints for RBAC and tenant management.
  
- **BGP Container** (`/containers/bgp`):
  Handles dynamic routing between spine and leaf nodes using **FRR** or **Bird** for BGP services.
  
- **WireGuard Container** (`/containers/wireguard`):
  Provides Layer 3 encryption using WireGuard for secure communication between tenant devices.
  
- **MACsec Container** (`/containers/macsec`):
  Encrypts Layer 2 traffic using MACsec between spine and leaf nodes.
  
- **GPU Offload Container** (`/containers/gpu-offload`):
  Offloads encryption and deep packet inspection to **NVIDIA GPUs** for accelerated performance.

#### **Web Interface**

- **Unified Dashboard** (`/containers/web`):
  Provides both user-facing and admin functionality. Users can manage their services (e.g., VPN), while admins can control container orchestration, monitor system performance, and handle encryption key management.
  
  Access the web interface at `http://<your-server-ip>:3000`.

#### **Monitoring and Logging**

- **Prometheus & Grafana**:
  Monitor real-time performance and system health. Preconfigured dashboards are available in `/monitoring/grafana/ztos-dashboard.json`.
  
- **Centralized Logging**:
  Logs are forwarded to `/logs/` directories for each service and can be centralized using **Fluentd** or **Elasticsearch**.

### Key Management

ZTOS includes tools for managing encryption keys across services like **MACsec** and **WireGuard**:
- Key rotation and revocation are automated through the API and Web UI.
- **Security.js** handles RBAC and key exchange for tenants.

### Security Features

ZTOS adheres to strict **Zero Trust** principles:
- **Role-Based Access Control (RBAC)**: Ensures that admins and users have minimal necessary privileges.
- **AppArmor Profiles**: Each container has its own security profile to prevent unauthorized access.
- **JWT/OAuth2 Authentication**: Used for user and API authentication.

### Testing and Validation

Tests are included to validate service functionality, security, and performance:
- **Container Security Tests**: Validate that each container follows its security policies.
- **Integration Tests**: Ensure that services like BGP and WireGuard work seamlessly together.
- **Performance Benchmarks**: Test the performance of GPU offloading and encryption services under load.

Run tests:
```
./tests/network-tests/gpu-offload-test.sh
./tests/security-tests/macsec-test.sh
```

## Future Plans

- **Further integration of MDM (Mobile Device Management)**: Bringing Zero Trust principles to endpoint devices like mobile phones, laptops, etc.
- **Expanded Client App**: An app to manage ZTOS connections and configurations on client devices (e.g., mobile VPN connections).
- **Complete Zero-Touch Setup**: Automating tenant onboarding and service deployment.

## Contributions

Contributions are welcome! Please submit pull requests or open issues on GitHub. For security concerns, email us at [security@ztos.com](mailto:security@ztos.com).

---

ZTOS is currently under **active development**. Check back for updates as we continue to build out this platform for scalable, secure networking.
