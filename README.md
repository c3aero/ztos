# ZTOS (Zero Trust Operating System)

**ZTOS** is a secure, scalable, and flexible operating system designed to implement **Zero Trust Networking** principles. It is deployable across cloud environments like **AWS**, hybrid infrastructures like **Equinix Metal**, and private on-premises hardware. ZTOS ensures multi-layer encryption, dynamic routing, and secure containerized network services for industries like Aerospace, Defense, Finance, and Government.

## Key Features

- **iPXE Booting**: Zero-touch deployment into cloud or bare-metal environments.
- **Custom Linux Distribution**: Networking-focused OS, optimized for routing and security services.
- **Multi-Layer Encryption**: Layer 2 encryption with **MACsec** and Layer 3 encryption with **WireGuard**.
- **Containerized Network Services**: Modular and scalable services such as **BGP**, **WireGuard**, and **MACsec**.
- **Zero Trust Networking**: Continuous authentication and least-privilege access to all network resources.
- **Multi-Tenant Support**: Fully isolated VRFs and VXLANs for traffic segmentation.

## Project Status

ZTOS is currently under active development. The repository includes the initial architecture design, boot process configurations, and containerized network services.

## Installation and Usage

### Prerequisites

- **iPXE** for network booting
- **Docker** or **Podman** for containerized services
- Access to **AWS**, **Equinix Metal**, or on-prem hardware

### Quick Start

1. Clone the repository:

   git clone https://github.com/c3aero/ztos.git
   cd ztos

2. Build the ZTOS kernel:

   Follow the instructions in **`docs/build-instructions.md`** to build the ZTOS kernel, create the initrd, and prepare the system for deployment.

3. Boot into ZTOS:

   Use iPXE to boot into ZTOS in your desired environment. Detailed instructions are available in **`docs/ipxe-boot-guide.md`** for AWS, Equinix Metal, and on-prem hardware.

4. Set up Network Services:

   Once ZTOS is booted, use Docker or Podman to run containerized services such as **BGP**, **WireGuard**, and **MACsec**. See **`docs/container-setup.md`** for more details on how to set up and run these services.

## Contributing

We welcome contributions from the community! Please feel free to submit pull requests or report issues. For major changes, please open an issue first to discuss what you would like to change.

## License

ZTOS is currently proprietary and licensed for internal use only by **C3Aero Group Inc.**. Please contact us for more information regarding usage and contributions.

