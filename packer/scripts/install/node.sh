# #!/bin/sh -x
# install node, npm, yarn
echo "===> Installing nodejs"
# Add package host for nodejs
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
# Install nodejs
apt-get install -y nodejs
npm install -g n
# Set node to use v6.6.0
n 6.6.0
npm update -g npm@3.10.7

echo "---> Install yarn"
npm install -g phantomjs-prebuilt@2.1.4
apt-get install yarn=0.16.1-1
