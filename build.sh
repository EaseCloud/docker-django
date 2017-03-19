#!/usr/bin/env bash

apt-get update

# TODO: faac missing

apt-get install -y \
    cron \
    openssl \
    vorbis-tools lame flac mpg123 libav-tools faad \  # media convert
    python3-tk \
    python3-dev btiff5-dev libtiff5-dev libffi-dev \  # dev libs
    libxml2-dev libxslt1-dev libssl-dev zlib1g-dev \
    liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev 

# compat avconv instead of ffmpeg
# link: https://wiki.debian.org/ffmpeg
ln /usr/bin/avconv /usr/bin/ffmpeg

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install -r /var/requirements.txt

echo "*/1 * * * * root /var/cron.sh" >> /etc/crontab
