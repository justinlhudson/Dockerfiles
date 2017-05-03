#!/bin/bash

_image=$1

_here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $_here
cd $_here

/usr/local/bin/docker-compose/docker-compose stop

# HACK: internet not working for docker?
sudo service docker restart
sudo iptables -t nat -F
sudo ifconfig docker0 down
sudo brctl delbr docker0
sudo service docker restart
sleep 1
docker stop $(docker ps -a -q --filter="name=$_image")
sleep 1

/usr/local/bin/docker-compose/docker-compose create
/usr/local/bin/docker-compose/docker-compose start
