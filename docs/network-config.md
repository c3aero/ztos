# ZTOS Network Configuration Guide

This guide provides a detailed overview of how to configure the core networking stack for ZTOS, including BGP, VXLAN, MACsec, and WireGuard. These components ensure secure, scalable, and isolated networking for your ZTOS environment.

---

## 1. BGP Configuration

**BGP (Border Gateway Protocol)** is used in ZTOS to dynamically route traffic between the spine and leaf nodes. BGP handles the routing of Layer 3 traffic, while EVPN extensions enable VXLAN to provide Layer 2 services over a Layer 3 network.

### Steps:
1. Install BGP (FRR or Bird) on each node.
2. Configure BGP neighbors (spine and leaf nodes) in `bgp.conf`:
   ```bash
   router bgp 64512
   bgp router-id 192.168.1.1
   neighbor 192.168.1.2 remote-as 64513
   network 192.168.100.0/24
3. Use EVPN to extend Layer 2 services over BGP by mapping VNI to VLAN:
	```bash
	vni 1001
	vxlan interface vxlan0
4. Test BGP routes:
```bash
show ip bgp summary