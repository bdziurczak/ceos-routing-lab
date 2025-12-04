#!/bin/bash
echo "root:root" | chpasswd
ip link set eth1 up  
dhclient -v eth1