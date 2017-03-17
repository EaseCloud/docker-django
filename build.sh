#!/usr/bin/env bash

apt-get update

apt-get install -y \
    cron \
    python3.5-dev \
    libffi-dev libxml2-dev libxslt1-dev \
    openssl libssl-dev \
    {gcc,g++}-arm-linux-gnueabi{,hf}

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install -r /var/requirements.txt

echo "*/1 * * * * root /var/cron.sh" >> /etc/crontab
