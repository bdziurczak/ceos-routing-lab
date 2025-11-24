#!/bin/bash
#IMPORTANT: use only if only containers that you run right now come from this virtual lab
runningps=$(docker ps -a -q)
if [[ -n "$runningps" ]]; then
    docker kill $runningps
fi
yes | clab destroy -ac
clab deploy
python3 ./netmiko/ceos_test.py
clab inspect 
