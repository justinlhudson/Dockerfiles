#!/bin/bash

_here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $_here
cd $_here

docker-compose stop

# HACK: internet not working for docker?
sudo service docker restart
sleep 5
sudo iptables -t nat -F
sudo ifconfig docker0 down
sudo brctl delbr docker0
sudo service docker restart
sleep 5

docker-compose create
docker-compose start
