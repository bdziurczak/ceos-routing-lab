#!/bin/bash
#IMPORTANT: use only if only containers that you run right now come from this virtual lab
runningps=$(docker ps -a -q)
if [[ -n "$runningps" ]]; then
    docker kill $runningps
fi
clab destroy -ac
clab deploy
