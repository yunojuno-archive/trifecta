FROM heroku/heroku:16

LABEL maintainer "YunoJuno <code@yunojuno.com>"

ARG PYTHON_VERSION=2.7.13

RUN echo "===> Installing Python $PYTHON_VERSION" \
    && echo "Installing prerequisites" \
    && apt-get update \
    && apt-get install -y \
        build-essential \
        libbz2-dev \
        libexpat1-dev \
        libgdbm-dev \
        liblzma-dev \
        libmemcached-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libnss3-dev \
        libpq-dev \
        libreadline-dev \
        libreadline6 \
        libreadline6-dev \
        libsqlite3-dev \
        libssl-dev \
        llvm \
        make \
        mercurial \
        python-dev \
        tk-dev \
        tk8.5-dev \
        wget \
        xz-utils \
        zlib1g-dev \
        zlib1g-dev \

    && echo "---> Downloading source files for Python $PYTHON_VERSION" \
    && cd /tmp \
    && wget http://python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && tar -xvf Python-$PYTHON_VERSION.tgz \
    && cd Python-$PYTHON_VERSION \

    && echo "---> Building Python from source" \
    && ./configure \
    && make \
    && make install \
    && python /tmp/get-pip.py \

    # cleanup
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*
