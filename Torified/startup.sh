#!/bin/bash

_image=$1

_here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $_here

cd $_here

sleep 1
docker stop $(docker ps -a -q --filter="name=$_image")
sleep 1

## HACK: internet not working for docker?
#DOCKER_OPTS="--dns 8.8.8.8"
service docker stop
pkill docker
iptables -t nat -F
ifconfig docker0 down
brctl delbr docker0
service docker start

#docker stop $(docker ps -a -q)
#docker rm $(docker ps -a -q)
#docker rmi $(docker images -a -q)

#while true
#do
docker-compose create && break
#  sleep 30
#done

docker-compose start
