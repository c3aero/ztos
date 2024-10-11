# ZTOS iPXE Boot Guide

## Overview

This guide explains how to use iPXE to boot ZTOS in different environments, including AWS, Equinix Metal, and on-premises hardware. iPXE allows ZTOS to be deployed dynamically without manual installation.

## Prerequisites

- Access to a supported environment (AWS, Equinix Metal, or physical hardware)
- iPXE boot server or environment set up

## Booting ZTOS on AWS

1. Create an AWS EC2 instance with network access.
2. Use the following iPXE script to boot into ZTOS:

```ipxe
#!ipxe
kernel https://ztos.example.com/kernel boot=zfs root=https://ztos.example.com/root.img
initrd https://ztos.example.com/initrd.img
boot

