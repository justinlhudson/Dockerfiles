# Dockerfiles
===========
## Notes

### Adding user to docker group to be able to run
```
sudo usermod -aG docker $USER
```

## Issues

### IPv4 to IPv6 Port Forwarding
IPv6 Forward
```
/etc/sysctl.conf
net.ipv6.conf.all.forwarding=1
```
### Docker bridge (no connection to internet)
Restart bridge
```
sudo iptables -t nat -F
sudo ifconfig docker0 down
sudo brctl delbr docker0
sudo service command docker restart
```
## Torified

### Implementation

Uses: [privoxy](https://www.privoxy.org/), and [tor](https://www.torproject.org/).  Has normal proxy at port @ 8123 and secure (using Tor) @ 8118

```
startup.sh
```

# Debug (in shell)
```
docker-compose run --service-ports torified bash
```

Default: user:password

```
alias torified="ssh -L 8118:127.0.0.1:8118 -L 8123:127.0.0.1:8123 user@[ip] -p 2222"
```
