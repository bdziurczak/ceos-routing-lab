#!/bin/bash
echo "root:root" | chpasswd
apt update
apt install -y iproute2
ip link set eth1 up