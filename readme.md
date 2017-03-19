Docker image for common use Django project 
==========================================

## Run a stand-alone docker container

> Notice: the example django project is named with myproject \
which could be created by: `django-admin startproject myproject`, \
which is expected placing under `/var/docker/django` folder.


```
docker run --name myproject \
       -p 8000:8000 \
       -v /var/docker/django/myproject:/var/app \
       -e PROJECT=myproject \
       huangwc/django:general
```

## Run with docker-compose

> Notice: in this example, we link to a mariadb server as a \
compose container. If you do so, the mysql host should be the \
link name *msyql*. You can also run it as an external service.

> Within Chinese network specifying dns server to `119.29.29.29` \
and `180.76.76.76` could be a better choice.

```
version: '2'

services:

  mariadb_main:
    image: mariadb:latest
    volumes:
     - /var/docker/mariadb/mysql:/var/lib/mysql
    environment:
     - TERM=dumb
    ports:
     - "3306:3306"

  myadmin:
    image: phpmyadmin/phpmyadmin
    links:
     - "mariadb_main:db"
    depends_on:
     - mariadb_main

  django_myproject:
    image: huangwc/django:general
    volumes:
     - /var/docker/django/myproject:/var/app
    links:
     - "mariadb_main:mysql"
    depends_on:
     - mariadb_main
    environment:
     - PROJECT=myproject
    dns:
     - 8.8.8.8
     - 8.8.4.4

  nginx:
    image: nginx
    ports:
     - "80:80"
     - "443:443"
    volumes:
     - /var/docker/nginx/conf.d:/etc/nginx/conf.d
     - /var/docker/django:/var/django
    depends_on:
     - myadmin
     - django_myproject
```

## Example nginx configuration

To make your nginx configuration up, put the config files \
under `/var/docker/nginx/conf.d`, with extension `.conf`

```
# /var/docker/nginx/conf.d/phpmyadmin.conf
server {
    listen       80;
    server_name  phpmyadmin.example.com;
    client_max_body_size 1000m;
    location / {
    proxy_read_timeout 1200;
    proxy_connect_timeout 1200;
    proxy_pass      http://myadmin;
    proxy_set_header    Host $host;
    proxy_set_header    X-Real-IP $remote_addr;
    proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

```
# /var/docker/nginx/conf.d/phpmyadmin.conf
server {
    listen 80;
    server_name myproject.example.com;
    client_max_body_size 50m;
    location / {
        proxy_redirect off;
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_pass http://django_myproject:8000;
    }
}
```

## About wsgi container and start script

This image contains a startup script which is located inside the \
container with path `/var/startup.sh`:

```
#!/usr/bin/env bash
set -e
service cron start
gunicorn -b 0.0.0.0:8000 \
         -k $WORKER_CLASS \
         -w $WORKERS \
         --reload \
         $PROJECT.wsgi
```

If you find it is nessesary to replace the startup script, for example \
to install new system packages or pip packages, you can volume another \
script to `/var/startup.sh`.

Like below if you use docker-compose:

```
django_myproject:
  # ...
  volumes:
   # ...
   - /path/to/startup.sh:/var/startup.sh
  # ...
```

## About `django-cron` integration

This image integrates with \
[django-cron](http://django-cron.readthedocs.io/), \
and the cron service is triggering the script \
`python manage.py runcrons` every minute.

So feel free to add `CronJobs` and they will be triggered \
properly.



