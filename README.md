# Dockerfiles
===========

## Torified

Usage:  ./DockerSetup --help


Tunnel: alias torified="ssh -L 8118:127.0.0.1:8118 -L 8123:127.0.0.1:8123 <username>@<ip>-p 2222"

### Implementation

Uses: polipo, prvoxy, and tor.  Has normal proxy at port @ 8123 and secure (using Tor) @ 8118
