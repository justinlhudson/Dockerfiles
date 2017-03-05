# Dockerfiles
===========
## Notes

### Adding user to docker group to be able to run
```
sudo usermod -aG docker $USER
```

### Implementation

Uses: [privoxy](https://www.privoxy.org/), and [tor](https://www.torproject.org/).  Has normal proxy at port @ 8123 and secure (using Tor) @ 8118

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
```
docker-compose up -d
```
Default: user:password

Note:  Is setup to always restart, so once start good to go forever.  But to feel good add this to cron job "@reboot cd [image directory] && compose start

```
alias torified="ssh -L 8118:127.0.0.1:8118 -L 8123:127.0.0.1:8123 user@[ip] -p 2222"
```
