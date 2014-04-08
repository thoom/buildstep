FROM phusion/baseimage:0.9.9
MAINTAINER thoom "zdp@thoomtech.com"

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare

## Install an SSH key
ADD docker_key.pub /tmp/docker_key.pub
RUN cat /tmp/docker_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/docker_key.pub

# Clean up APT when done.
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && apt-get clean
