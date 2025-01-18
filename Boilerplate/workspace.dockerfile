# https://docs.docker.com/reference/dockerfile/

# Ubuntu base image
FROM ubuntu:latest

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt update && apt install -y \
    build-essential \
    curl \
    wget \
    vim \
    git \
    expect \
    openssh-server \
    supervisor \
    python3 \
    python3-dev

# Default user: "user:password"
RUN echo root:root | chpasswd
RUN adduser user && adduser user sudo
RUN echo user:password | chpasswd

# Python Virtual Environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# SSH Server
RUN mkdir /var/run/sshd

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup helper
COPY start.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh
RUN /tmp/setup.sh

# Port(s)
EXPOSE 22

# Workspace creation
WORKDIR workspace
COPY ./workspace ./

# Startup application
CMD ["/usr/bin/supervisord"]