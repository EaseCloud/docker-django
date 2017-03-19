#!/bin/bash
cd /var/app
python manage.py runcrons >> /var/log/django_cron.log 2>> /var/log/django_cron.err.log
