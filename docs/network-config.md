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

---

## 2. VXLAN Configuration

**VXLAN (Virtual Extensible LAN)** provides Layer 2 overlay on top of the Layer 3 underlay network, enabling isolated Layer 2 networks for each tenant. ZTOS uses VXLAN for encapsulating Layer 2 traffic between leaf nodes.

### Steps:
1. Create VXLAN interface:
   ip link add vxlan0 type vxlan id 42 dev eth0 dstport 4789
   ip addr add 192.168.100.1/24 dev vxlan0
   ip link set up vxlan0

2. Link the VXLAN ID to the corresponding VLAN:
   bridge vlan add vid 10 dev vxlan0

3. Test VXLAN functionality by verifying the tunnel:
   bridge fdb show dev vxlan0

---

## 3. MACsec Configuration

**MACsec (Media Access Control Security)** provides encryption for Layer 2 traffic in ZTOS. It encrypts VXLAN traffic as it flows between leaf nodes, ensuring that even if traffic is intercepted, the payload remains secure.

### Steps:
1. Install necessary tools for MACsec on the nodes.
2. Configure MACsec on the interface:
   ip link add link eth0 macsec0 type macsec
   ip macsec add macsec0 tx sa 0 pn 1 on key 01 0123456789abcdef
   ip link set up macsec0

3. Link MACsec to the VXLAN interface:
   ip link set macsec0 master vxlan0

4. Verify MACsec configuration:
   ip macsec show

---

## 4. WireGuard Configuration

**WireGuard** provides Layer 3 encryption in ZTOS, securing traffic between spine and leaf nodes. WireGuard encrypts all traffic, ensuring data privacy during transit over the network.

### Steps:
1. Install WireGuard on the nodes.
2. Create the WireGuard configuration (`wg0.conf`):
   [Interface]
   Address = 10.0.0.1/24
   PrivateKey = YOUR_PRIVATE_KEY
   ListenPort = 51820

   [Peer]
   PublicKey = PEER_PUBLIC_KEY
   AllowedIPs = 10.0.0.2/32

3. Start the WireGuard interface:
   wg-quick up /etc/wireguard/wg0.conf

4. Verify that the WireGuard connection is active:
   wg show

---

## Conclusion

This guide outlines the key networking components of ZTOS. For more detailed troubleshooting or advanced configuration, consult the respective tool's documentation (FRR for BGP, WireGuard, MACsec utilities).
