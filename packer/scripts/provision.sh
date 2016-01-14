#!/bin/bash
# ------------------------------------------------
# Vagrant provisioning script used to create a new
# box from ubuntu/trusty64 box.
#
# - Update python from 2.7.6 to 2.7.9
# - Install virtualenv (+wrapper)
# - Install foreman (to run Procfile and use .env)
# - Install docker and docker-compose
# ------------------------------------------------
#
echo "-> Update installed packages"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y

echo "-> Install libraries required to build python from source"
sudo apt-get install -y \
    build-essential \
    libbz2-dev \
    libexpat1-dev \
    libgdbm-dev \
    liblzma-dev \
    libmemcached-dev \
    libncurses5-dev \
    libnss3-dev \
    libpq-dev \
    libreadline6 libreadline6-dev \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    mercurial \
    python-dev \
    tk8.5-dev \
    zlib1g-dev \
    vim

echo "-> Downloading source files for Python 2.7.9"
cd /tmp;
wget http://python.org/ftp/python/2.7.9/Python-2.7.9.tgz;
tar -xvf Python-2.7.9.tgz;
cd Python-2.7.9;

echo "-> Building Python from source"
./configure;
make;
sudo make install;

echo "-> Installing pip"
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user
# set PATH so it includes user's .local bin if it exists
echo "
if [ -d \"\$HOME/.local/bin\" ] ; then
    PATH=\"\$HOME/.local/bin:\$PATH\"
fi
" >> $HOME/.profile
source ~/.profile

echo "-> Installing virtualenv and virtualenvwrapper"
pip install --user virtualenv virtualenvwrapper mercurial
echo "export WORKON_HOME=\$HOME/.virtualenvs" >> $HOME/.profile
echo "source \$HOME/.local/bin/virtualenvwrapper.sh" >> $HOME/.profile
source ~/.profile

echo "-> Installing Heroku toolbelt (inc. foreman)"
sudo wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

echo "-> Installing docker"
wget -qO- https://get.docker.com/ | sh
echo "-> Adding user to docker group"
sudo usermod -aG docker vagrant

echo "-> Installing docker-compose"
pip install --user docker-compose

echo """
# ======================================================================
#
# Congratulations, you now have a vanilla development environment.
#
# * Pip, Mercurial, Git, Python-dev are used to install python deps
# * Virtualenv is used to run the Django app in isolation
# * Docker and docker-compose to run containers
#
# ======================================================================
"""
