FROM phusion/baseimage:0.9.9
MAINTAINER thoom "zdp@thoomtech.com"

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

## Install an SSH key
ADD docker_key.pub /tmp/docker_key.pub
RUN cat /tmp/docker_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/docker_key.pub

## Update the nginx conf
ADD nginx.conf /etc/nginx/nginx.conf
