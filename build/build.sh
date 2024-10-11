#!/bin/bash

# ZTOS Build Script
# This script builds the ZTOS image, kernel, and initrd

# Variables
KERNEL_VERSION="5.15"
BUILD_DIR="$(pwd)/build"
OUTPUT_DIR="$BUILD_DIR/output"

echo "Building ZTOS Kernel..."
mkdir -p $OUTPUT_DIR
cd $BUILD_DIR/kernel
make bzImage

echo "Creating initrd..."
cd $BUILD_DIR/initrd
# Commands to build initrd go here

echo "Packaging ZTOS..."
# Commands to package kernel and initrd into bootable image

