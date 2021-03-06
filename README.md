# Dockerfiles
===========
## Notes

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

```
alias torified="ssh -L 8118:127.0.0.1:8118 -L 8123:127.0.0.1:8123 user@[ip] -p 2222"
```
