FROM phusion/baseimage:0.9.9
MAINTAINER thoom "zdp@thoomtech.com"

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

# HHVM buildpack needs to have the .18 symlinked to .16 which looks like a common solution
RUN ln -s /usr/lib/x86_64-linux-gnu/libmysqlclient.so.18 /usr/lib/x86_64-linux-gnu/libmysqlclient.so.16
RUN ln -s /usr/lib/x86_64-linux-gnu/libmysqlclient.so.18.0.0 /usr/lib/x86_64-linux-gnu/libmysqlclient.so.16.0.0
RUN ln -s /usr/lib/x86_64-linux-gnu/libmysqlclient_r.so.18 /usr/lib/x86_64-linux-gnu/libmysqlclient_r.so.16
RUN ln -s /usr/lib/x86_64-linux-gnu/libmysqlclient_r.so.18.0.0 /usr/lib/x86_64-linux-gnu/libmysqlclient_r.so.16.0.0

## Install an SSH key
ADD docker_key.pub /tmp/docker_key.pub
RUN cat /tmp/docker_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/docker_key.pub
