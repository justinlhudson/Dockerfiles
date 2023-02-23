# Base image
FROM ubuntu:20.04

# timezone
ENV TZ="UTC"

# Disable Prompt During Packages Installation
#ARG DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND noninteractive

RUN apt update; apt upgrade -y
RUN apt autoremove -y; apt autoclean -y
RUN apt install -y sudo vim expect supervisor fail2ban

# when using sshd to spawn shells
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# default user as user:password
RUN echo root:root | chpasswd
RUN adduser user && adduser user sudo
RUN echo user:password | chpasswd

# supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]

## specifics to container ##
RUN apt-get -y install openssh-server privoxy tor

EXPOSE "22"
RUN mkdir -p /var/run/sshd/

EXPOSE "8119"
ADD privoxy.conf /etc/privoxy/config
EXPOSE "8118"
ADD privoxy-tor.conf /etc/privoxy/config-tor

EXPOSE "9001"
EXPOSE "9030"
EXPOSE "9050"
ADD tor.conf /etc/tor/

# Note: doing all in one command is less container commits
#ADD setup.sh /tmp/setup.sh
#RUN chmod +x /tmp/setup.sh; chown root:root /tmp/setup.sh; /tmp/setup.sh
