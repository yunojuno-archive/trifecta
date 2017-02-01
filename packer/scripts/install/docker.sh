# #!/bin/sh -x
echo "===> Installing docker"
wget -qO- https://get.docker.com/ | sh
echo "---> Adding user to docker group"
usermod -aG docker vagrant
