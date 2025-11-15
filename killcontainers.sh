#!/bin/bash
#when I redeploy labs there's often problem that clab destroy don't remove containers. this simple script automate killing containers
# then it deploys lab
docker stop $(docker ps -a -q)
sleep 5
docker kill $(docker ps -a -q)

sudo clab deploy
