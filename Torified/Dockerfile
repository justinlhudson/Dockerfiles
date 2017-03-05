# Base image
FROM ubuntu:12.04

# Allow it to work regardless of locale/language set on the users machine
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

ADD sources.list /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y apt-utils sudo vim expect supervisor
RUN apt-get install -f; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y; apt-get autoclean -y

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN echo root:root | chpasswd
RUN adduser user && adduser user sudo
RUN echo user:password | chpasswd

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]

# specifics to container
RUN apt-get -y install openssh-server privoxy tor

EXPOSE "22"
RUN mkdir -p /var/run/sshd/

EXPOSE "8123"
ADD privoxy.conf /etc/privoxy/config
EXPOSE "8118"
ADD privoxy-tor.conf /etc/privoxy/config-tor

EXPOSE "9001"
EXPOSE "9030"
ADD tor.conf /etc/tor/


# Note: doing all in one command is less container commits
#ADD setup.sh /tmp/setup.sh
#RUN chmod +x /tmp/setup.sh; chown root:root /tmp/setup.sh; /tmp/setup.sh
