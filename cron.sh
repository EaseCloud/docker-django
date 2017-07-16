#!/bin/bash
cd /var/app
pyp3 manage.py runcrons >> /var/log/django_cron.log 2>> /var/log/django_cron.err.log
