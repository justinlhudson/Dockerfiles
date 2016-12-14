# Dockerfiles
===========

## Torified

Usage:  docker-compose up

Default: user:password

Note:  Is setup to always restart, so once start good to go forever.  But to feel good add this to cron job "@reboot cd [image directory] && compose up

Tunnel: alias torified="ssh -L 8118:127.0.0.1:8118 -L 8123:127.0.0.1:8123 user@[ip] -p 2222"

### Implementation

Uses: [polipo](https://github.com/jech/polipo), [privoxy](https://www.privoxy.org/), and [tor](https://www.torproject.org/).  Has normal proxy at port @ 8123 and secure (using Tor) @ 8118
