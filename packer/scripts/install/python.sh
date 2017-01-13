!/bin/sh -x
echo "===> Installing Python $PYTHON_VERSION"
echo "---> Removing default system Python"
apt-get -y purge \
    python-dbus \
    libnl1 \
    python-smartpm \
    python-twisted-core \
    libiw30 \
    python-twisted-bin \
    libdbus-glib-1-2 \
    python-pexpect \
    python-pycurl \
    python-serial \
    python-gobject \
    python-pam \
    python-openssl \
    libffi5

echo "---> Install libraries required to build python from source"
apt-get install -y \
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
    zlib1g-dev

echo "---> Downloading source files for Python $PYTHON_VERSION"
cd /tmp;
wget http://python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz;
tar -xvf Python-$PYTHON_VERSION.tgz;
cd Python-$PYTHON_VERSION;

echo "---> Building Python from source"
./configure;
make;
make install;
