FROM phusion/baseimage:0.9.9
MAINTAINER thoom "zdp@thoomtech.com"

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

## Install an SSH key
ADD build_key /tmp/build_key.pub
RUN cat /tmp/build_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/build_key.pub
