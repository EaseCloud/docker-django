FROM python:latest
MAINTAINER huangwc@easecloud.cn

WORKDIR /var/app

ENV PROJECT=app

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y

RUN pip install --upgrade pip && pip install gunicorn django greenlet eventlet 

COPY ./startup.sh /var

RUN chmod +x /var/startup.sh 

VOLUME ["/var/app", "/var/app/media"]

EXPOSE 8000

CMD ["/var/startup.sh"]


