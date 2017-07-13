#!/usr/bin/env bash

apt-get update

# TODO: faac missing

apt-get install -y \
    cron \
    openssl \
    vorbis-tools lame flac mpg123 libav-tools faad \
    python3-tk python3-dev libtiff5-dev libffi-dev \
    libxml2-dev libxslt1-dev libssl-dev zlib1g-dev \
    liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev 

# compat avconv instead of ffmpeg
# link: https://wiki.debian.org/ffmpeg
ln /usr/bin/avconv /usr/bin/ffmpeg

wget https://bootstrap.pypa.io/get-pip.py
pypy3 get-pip.py

pypy3 -m pip install -r /var/requirements.txt

echo "*/1 * * * * root /var/cron.sh" >> /etc/crontab
