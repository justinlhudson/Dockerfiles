#!/bin/bash

_image=$1

_here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $_here

cd $_here

#docker-compose stop

## HACK: internet not working for docker?
#DOCKER_OPTS="--dns 8.8.8.8"
service docker stop
pkill docker
iptables -t nat -F
ifconfig docker0 down
brctl delbr docker0
service docker start

sleep 1
docker stop $(docker ps -a -q --filter="name=$_image")
sleep 1

#docker stop $(docker ps -a -q)
#docker rm $(docker ps -a -q)
#docker rmi $(docker images -a -q)

docker-compose create
docker-compose start
