#!/usr/bin/env bash

apt-get update

# TODO: faac missing

apt-get install -y `cat /var/apt-requirements.txt`

# compat avconv instead of ffmpeg
# link: https://wiki.debian.org/ffmpeg
ln /usr/bin/avconv /usr/bin/ffmpeg

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install `cat /var/requirements.txt`

echo "*/1 * * * * root PYTHONIOENCODING=UTF-8 /var/cron.sh" >> /etc/crontab
