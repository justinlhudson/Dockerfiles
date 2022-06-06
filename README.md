# Dockerfiles
===========
## Notes

### Prerequisites
docker, docker-compose

### Adding user to docker group to be able to run
```
sudo usermod -aG docker $USER
```

## Issues

### IPv4 Forwarding
```
/etc/sysctl.conf
net.ipv4.ip_forward=1
```
### Docker bridge (no connection to internet)
Restart bridge
- DEPRECATED
<s>
```
sudo iptables -t nat -F
sudo ifconfig docker0 down
sudo brctl delbr docker0
sudo service command docker restart
```
</s>

## Torified

### Implementation

Uses: [privoxy](https://www.privoxy.org/), and [tor](https://www.torproject.org/).  Has normal proxy at port @ 8123 and secure (using Tor) @ 8118

Default: user:password

```
docker-compose build --force-rm --no-cache
docker-compose up -d
```

#### Debug (in shell)
```
docker-compose run --service-ports torified bash
```
