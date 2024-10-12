# ZTOS Build Instructions

This guide outlines how to build the core ZTOS system, including compiling the kernel, creating the initrd, installing Docker, setting up Systemd to run Docker, and packaging everything for deployment. It also includes steps for containerizing key network services and automating their startup.

---

## 1. Build the Kernel

ZTOS uses a custom Linux kernel with support for features like BGP, VXLAN, MACsec, and WireGuard. Follow the steps below to compile the kernel.

### Prerequisites:
- Ensure you have **build-essential** tools installed:
	sudo apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev

### Steps:

1. Download the Linux kernel source (example with Linux 5.15):
	wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz
	tar -xf linux-5.15.tar.xz
	cd linux-5.15

2. Configure the kernel:
	make defconfig
	make menuconfig

- **Enable necessary options**:
  - **Networking support** (for BGP, VXLAN)
  - **Security options** (for MACsec and WireGuard)
  - In **Networking options** → **Network support**, select **VXLAN**.
  - In **Cryptographic API**, select **MACsec support**.
  - Enable **WireGuard** in **Networking support** → **Network Device Support**.

3. Build the kernel:
	make -j$(nproc)

4. Install the modules and the kernel:
	sudo make modules_install
	sudo make install

5. Confirm that the kernel and modules were installed correctly:
	ls /boot | grep vmlinuz
	ls /lib/modules | grep 5.15

---

## 2. Create the Initrd

The **initrd** (initial RAM disk) is responsible for loading essential drivers during the early boot process. This will contain the drivers for your networking stack and storage.

### Prerequisites:
- Install **dracut** or a similar tool for generating the initrd:
	sudo apt-get install dracut

### Steps:

1. Create the initrd:
	sudo dracut --force /boot/initrd.img-5.15

2. Verify the initrd was created:
	ls /boot | grep initrd

---

## 3. Install Docker and Prepare Containers for Boot

Docker is used to run the containerized services after boot. This section includes steps for installing Docker, building the containers, and configuring Systemd to manage the containers.

### Steps:

1. Install Docker:
   sudo apt-get install docker.io -y

2. **Build the Containers**:
   - **BGP Container**:
		cd containers/bgp
		docker build -t ztos-bgp .
   - **WireGuard Container**:
		cd containers/wireguard
		docker build -t ztos-wireguard .
   - **MACsec Container**:
		cd containers/macsec
		docker build -t ztos-macsec .
   - **GPU Offload Container**:
		cd containers/gpu-offload
		docker build -t ztos-gpu-offload .

---

## 4. Configure Systemd to Start Docker and Launch Containers

To automate the process of running Docker and starting the containers at boot, we’ll create Systemd service files.

### Steps:

1. Create a **Systemd service file** to start Docker at boot. Create `/etc/systemd/system/docker.service`:

	```ini
	[Unit]
	Description=Docker Application Container Engine
	Documentation=https://docs.docker.com
	After=network.target

	[Service]
	ExecStart=/usr/bin/dockerd -H unix://
	Restart=always
	RestartSec=10

	[Install]
	WantedBy=multi-user.target
	```

2. Enable Docker to start at boot:
	sudo systemctl enable docker

3. Create another **Systemd service** to launch your containers with Docker Compose. Create `/etc/systemd/system/ztos-containers.service`:

	```ini
	[Unit]
	Description=ZTOS Containers Service
	Requires=docker.service
	After=docker.service

	[Service]
	WorkingDirectory=/path/to/docker-compose-directory
	ExecStart=/usr/local/bin/docker-compose up
	ExecStop=/usr/local/bin/docker-compose down
	Restart=always
	RestartSec=5

	[Install]
	WantedBy=multi-user.target
	```

4. Enable the **ztos-containers** service so it starts at boot:
	sudo systemctl enable ztos-containers

---

## 5. Package for iPXE Boot

To boot ZTOS over the network using iPXE, you’ll need to package the kernel, initrd, and any additional files into a format that can be served over HTTP or TFTP.

### Steps:

1. Copy the kernel and initrd to the output directory:
	mkdir -p output
	cp /boot/vmlinuz-5.15 output/
	cp /boot/initrd.img-5.15 output/

2. Create an iPXE script to boot ZTOS:

	#!ipxe
	kernel https://example.com/path/to/output/vmlinuz-5.15
	initrd https://example.com/path/to/output/initrd.img-5.15
	boot

3. Host the `output/` directory on an HTTP server or make it available through TFTP for booting.

---

## 6. Build the ISO (Optional)

If you want to create an ISO image for booting ZTOS from physical media (e.g., USB or CD), you can package the kernel and initrd into an ISO image.

### Steps:

1. Install **xorriso** (for creating ISO images):
	sudo apt-get install xorriso

2. Create a bootable ISO image:
	mkdir -p iso/boot
	cp output/vmlinuz-5.15 iso/boot/vmlinuz
	cp output/initrd.img-5.15 iso/boot/initrd.img

	xorriso -as mkisofs \
	   -o ztos.iso \
	   -b boot/vmlinuz \
	   -c boot/initrd.img \
	   iso/

3. Verify that the ISO has been created:
	ls | grep ztos.iso

---

## Conclusion

By following these steps, you will have built the ZTOS kernel, created an initrd, installed Docker, and configured Systemd to automatically start Docker and run all containerized services (BGP, WireGuard, MACsec, and GPU Offload) at boot. This ensures that ZTOS is fully functional and ready for deployment via iPXE or ISO.
