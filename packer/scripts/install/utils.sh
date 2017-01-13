#!/bin/sh -x
# this script is run as the local user so that --user works
echo "===> Installing useful utils"
apt-get install -y \
    redis-tools \
    libjpeg-dev \
    libffi-dev \
    htop \
    gettext \
    vim
