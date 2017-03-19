#!/usr/bin/env bash
set -e
service cron start
gunicorn -b 0.0.0.0:8000 \
         -k $WORKER_CLASS \
         -w $WORKERS \
         --reload \
         $PROJECT.wsgi
