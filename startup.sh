#!/bin/bash

set -e

echo $PROJECT

if [ ! -e ./manage.py ]; then
    django-admin startproject $PROJECT .
fi

gunicorn -b 0.0.0.0:8000 -w 4 -k eventlet $PROJECT.wsgi
