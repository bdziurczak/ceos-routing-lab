#!/bin/bash
echo "root:root" | chpasswd
apt update
apt install -y iproute2
ip address add 203.10.0.1/24 dev eth1
ip address add 203.20.0.1/24 dev eth2
ip route add 10.2.2.0/24 via 203.20.0.113
ip route add 10.1.1.0/24 via 203.10.0.113
ip route add 112.112.112.0/24 via 203.10.0.113 
ip route add 112.112.114.0/24 via 203.10.0.113 
ip route add 112.112.113.0/24 via 203.20.0.113 
ip route add 112.112.115.0/24 via 203.20.0.113
ip route add 192.168.150.128/25 via 203.10.0.113
sysctl -w net.ipv4.ip_forward=1
iptables -P FORWARD ACCEPT #Because this linux machine works as WAN simulator, its not a firewall

#adding latency, jitter, packet loss
tc qdisc add dev eth1 root netem delay 10ms 5ms loss 3%
tc qdisc add dev eth2 root netem delay 10ms 5ms loss 3%
