#!/usr/bin/env bash

set -e

echo $PROJECT

#if [ ! -e ./manage.py ]; then
#    django-admin startproject $PROJECT .
#fi

#if [ -f ./requirements.txt ]; then
#    pip install -r requirements.txt
#fi

gunicorn -b 0.0.0.0:8000 -w 4 -k eventlet --reload $PROJECT.wsgi
