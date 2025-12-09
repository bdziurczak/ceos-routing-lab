#!/bin/bash
echo "root:root" | chpasswd
ip link set eth1 up
dhclient -v eth1
ip route add 112.112.116.0/24 via 192.168.150.1
ip route add 112.112.114.0/24 via 192.168.150.1
ip route add 192.168.150.128/25 via 192.168.150.1