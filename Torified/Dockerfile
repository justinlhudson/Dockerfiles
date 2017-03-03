# Base image
FROM ubuntu:14.04

# Allow it to work regardless of locale/language set on the users machine
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

ADD sources.list /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y apt-utils sudo vim expect openssh-server supervisor
RUN apt-get install -f; apt-get update -y; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y; apt-get autoclean -y

RUN mkdir -p /var/run/sshd; mkdir -p /var/log/supervisor; mkdir -p /root/.ssh
RUN echo "export VISIBLE=now" >> /etc/profile

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN echo "root:root" | chpasswd
RUN adduser user && adduser user sudo
RUN echo "user:password" | chpasswd

CMD ["/usr/bin/supervisord"]

# specifics to container
RUN apt-get -y install privoxy tor polipo || true

EXPOSE 8123
ADD privoxy.conf /etc/privoxy/config

EXPOSE 9001 9030
ADD tor.conf /etc/tor/

EXPOSE 8118
ADD polipo.conf /etc/polipo/conf

# Note: doing all in one command is less container commits
#ADD setup.sh /tmp/setup.sh
#RUN chmod +x /tmp/setup.sh; chown root:root /tmp/setup.sh; /tmp/setup.sh
