#!/bin/bash

# Variables
KERNEL_VERSION="5.15"
ROOTFS_DIR="ztos-rootfs"

# Step 1: Create the root filesystem using debootstrap
echo "Creating root filesystem..."
sudo apt-get install -y debootstrap
sudo debootstrap --arch=amd64 bullseye $ROOTFS_DIR http://deb.debian.org/debian/

# Step 2: Install additional packages in the root filesystem
echo "Installing system tools in root filesystem..."
sudo mount --bind /dev $ROOTFS_DIR/dev
sudo chroot $ROOTFS_DIR /bin/bash <<EOF
apt-get update
apt-get install -y systemd bash iproute2 iputils-ping net-tools curl docker.io
exit
EOF
sudo umount $ROOTFS_DIR/dev

# Step 3: Create initrd
echo "Creating initrd..."
sudo apt-get install -y dracut
sudo dracut --force /boot/initrd.img-$KERNEL_VERSION

# Step 4: Package kernel, initrd, and root filesystem
echo "Packing kernel, initrd, and root filesystem..."
mkdir -p output
cp /boot/vmlinuz-$KERNEL_VERSION output/
cp /boot/initrd.img-$KERNEL_VERSION output/
tar -czf output/ztos-rootfs.tar.gz $ROOTFS_DIR

echo "Build complete. Files are ready for booting."

