#!/bin/bash

KERNEL_VERSION="5.15"
BUILD_DIR="$(pwd)/build"
OUTPUT_DIR="$BUILD_DIR/output"

# Clean previous builds
rm -rf $OUTPUT_DIR/*
mkdir -p $OUTPUT_DIR

# Step 1: Fetch Kernel Source
echo "Fetching Kernel Source..."
cd $BUILD_DIR/kernel
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$KERNEL_VERSION.tar.xz
tar -xf linux-$KERNEL_VERSION.tar.xz
cd linux-$KERNEL_VERSION

# Step 2: Build Kernel
echo "Building Kernel..."
make defconfig
make bzImage -j$(nproc)

# Step 3: Create Initrd
echo "Creating Initrd..."
cd $BUILD_DIR/initrd
# Add initrd creation commands here (e.g., dracut or busybox-based initrd)

# Step 4: Package Kernel and Initrd
echo "Packaging Kernel and Initrd..."
cp $BUILD_DIR/kernel/linux-$KERNEL_VERSION/arch/x86/boot/bzImage $OUTPUT_DIR/
cp $BUILD_DIR/initrd/initrd.img $OUTPUT_DIR/
