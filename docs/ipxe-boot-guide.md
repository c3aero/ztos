# ZTOS iPXE Boot Guide

## Overview

This guide explains how to use iPXE to boot ZTOS in different environments, including AWS, Equinix Metal, and on-premises hardware. iPXE allows ZTOS to be deployed dynamically without manual installation.

## Prerequisites

- Access to a supported environment (AWS, Equinix Metal, or physical hardware)
- iPXE boot server or environment set up

## Booting ZTOS on AWS

1. Create an AWS EC2 instance with network access.
2. Use the following iPXE script to boot into ZTOS:

	```bash
	#!ipxe  
	kernel https://ipxe.example.com/kernel boot=zfs root=https://ipxe.example.com/root.img  
	initrd https://ipxe.example.com/initrd.img  
	boot

3. Ensure the EC2 instance has access to the internet and the above URLs are reachable. ZTOS will load automatically once the script is executed.

## Booting ZTOS on Equinix Metal

1. Log into your Equinix Metal account and create a new server.
2. During server setup, select **Custom iPXE** as the operating system.
3. Paste the following iPXE script into the iPXE boot section:

	```bash
	#!ipxe  
	kernel https://ipxe.example.com/kernel boot=zfs root=https://ipxe.example.com/root.img  
	initrd https://ipxe.example.com/initrd.img  
	boot

4. Boot the Equinix Metal server, and ZTOS will automatically load using the provided kernel and initrd.

## Booting ZTOS on On-Premises Hardware

1. Set up a DHCP and TFTP server on your local network if you haven’t already.
2. Connect the physical machine to your network and configure it to boot via PXE.
3. On your DHCP/TFTP server, configure the iPXE boot file with the following script:

	```bash
	#!ipxe  
	kernel https://ipxe.example.com/kernel boot=zfs root=https://ipxe.example.com/root.img  
	initrd https://ipxe.example.com/initrd.img  
	boot

4. Ensure that the machine can reach the internet, and ZTOS will boot automatically.

## Conclusion

This guide explains how to boot ZTOS in different environments (AWS, Equinix Metal, and on-premises hardware) using iPXE. Ensure the URLs for the kernel and initrd are accessible, and your environment is properly configured for network booting. If you have any issues, verify your network settings and connectivity.
