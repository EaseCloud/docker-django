#!/usr/bin/env bash

apt-get update

apt-get install -y \
    python3.5-dev \
    libffi-dev libxml2-dev libxslt1-dev \
    openssl libssl-dev \
    {gcc,g++}-arm-linux-gnueabi{,hf}

wget https://bootstrap.pypa.io/get-pip.py
python3.5 get-pip.py

pip3.5 install -r requirements.txt
