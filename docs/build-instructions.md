# ZTOS Build Instructions

This guide outlines how to build the core ZTOS system, including compiling the kernel, creating the initrd, and packaging everything for deployment.

---

## 1. Build the Kernel

ZTOS uses a custom Linux kernel with support for features like BGP, VXLAN, MACsec, and WireGuard. Follow the steps below to compile the kernel.

### Prerequisites:
- Ensure you have **build-essential** tools installed:
	```bash
   sudo apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev

### Steps:

1. Download the Linux kernel source (example with Linux 5.15):
	```bash
   wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz
   tar -xf linux-5.15.tar.xz
   cd linux-5.15

2. Configure the kernel:
	```bash
   make defconfig
   make menuconfig

- **Enable necessary options**:
- **Networking support** (for BGP, VXLAN)
- **Security options** (for MACsec and WireGuard)
- You may want to enable the following manually:
- Go to **Networking options** → **Network support** and select **VXLAN**.
- Go to **Cryptographic API** → **MACsec support**.
- Enable **WireGuard** in **Networking support** → **Network Device Support**.

3. Build the kernel:
	```bash
   make -j$(nproc)

4. Install the modules and the kernel:
	```bash
   sudo make modules_install
   sudo make install

5. Confirm that the kernel and modules were installed correctly:
	```bash
   ls /boot | grep vmlinuz
   ls /lib/modules | grep 5.15

---

## 2. Create the Initrd

The **initrd** (initial RAM disk) is responsible for loading essential drivers during the early boot process. This will contain the drivers for your networking stack and storage.

### Prerequisites:
- Install **dracut** or a similar tool for generating the initrd:
	```bash
   sudo apt-get install dracut

### Steps:

1. Create the initrd:
	```bash
   sudo dracut --force /boot/initrd.img-5.15

2. Verify the initrd was created:
	```bash
   ls /boot | grep initrd

---

## 3. Package for iPXE Boot

To boot ZTOS over the network using iPXE, you’ll need to package the kernel and initrd into a format that can be served over HTTP or TFTP.

### Steps:

1. Copy the kernel and initrd to the output directory:
	```bash
   mkdir -p output
   cp /boot/vmlinuz-5.15 output/
   cp /boot/initrd.img-5.15 output/

2. Create an iPXE script to boot ZTOS. You can modify the iPXE boot configuration depending on your environment (AWS, Equinix Metal, or on-prem hardware). For instance:

   **iPXE script example**:
   ```bash
   #!ipxe
   kernel https://yourdomain.com/path/to/output/vmlinuz-5.15
   initrd https://yourdomain.com/path/to/output/initrd.img-5.15
   boot

3. Host the `output/` directory on an HTTP server or make it available through TFTP for booting.

---

## 4. Build the ISO (Optional)

If you want to create an ISO image for booting ZTOS from physical media (e.g., USB or CD), you can package the kernel and initrd into an ISO image.

### Steps:

1. Install **xorriso** (for creating ISO images):
	```bash
   sudo apt-get install xorriso

2. Create a bootable ISO image:
	```bash
   mkdir -p iso/boot
   cp output/vmlinuz-5.15 iso/boot/vmlinuz
   cp output/initrd.img-5.15 iso/boot/initrd.img

   xorriso -as mkisofs \
      -o ztos.iso \
      -b boot/vmlinuz \
      -c boot/initrd.img \
      iso/

3. Verify that the ISO has been created:
	```bash
   ls | grep ztos.iso

---

## 5. Optional: Automating the Build Process

You can automate this entire build process by creating a **build.sh** script. This script will handle downloading the kernel, configuring it, building the kernel and initrd, and packaging everything into a bootable format.

Here’s an example **build.sh** script:

	```bash
	!/bin/bash
	# Variables
	KERNEL_VERSION="5.15"
	OUTPUT_DIR="$(pwd)/output"
	ISO_DIR="$(pwd)/iso"
	
	# Step 1: Download Kernel Source
	wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$KERNEL_VERSION.tar.xz
	tar -xf linux-$KERNEL_VERSION.tar.xz
	cd linux-$KERNEL_VERSION

	# Step 2: Build Kernel
	make defconfig
	make menuconfig  # Optional: Customize configuration
	make -j$(nproc)
	sudo make modules_install
	sudo make install

	# Step 3: Create Initrd
	sudo dracut --force /boot/initrd.img-$KERNEL_VERSION
	
	# Step 4: Package for Booting
	mkdir -p $OUTPUT_DIR
	cp /boot/vmlinuz-$KERNEL_VERSION $OUTPUT_DIR/
	cp /boot/initrd.img-$KERNEL_VERSION $OUTPUT_DIR/
	
	# Step 5: Create ISO (Optional)
	mkdir -p $ISO_DIR/boot
	cp $OUTPUT_DIR/vmlinuz-$KERNEL_VERSION $ISO_DIR/boot/vmlinuz
	cp $OUTPUT_DIR/initrd.img-$KERNEL_VERSION $ISO_DIR/boot/initrd.img

	xorriso -as mkisofs \
	   -o ztos.iso \
	   -b boot/vmlinuz \
	   -c boot/initrd.img \
	   $ISO_DIR/
	   
	echo "Build Complete!"

## Conclusion

By following these steps, you will have built the ZTOS kernel, created an initrd, and packaged the system for deployment using iPXE or ISO. These instructions form the foundation for deploying ZTOS in a variety of environments, from cloud platforms like AWS and Equinix Metal to on-prem hardware.


