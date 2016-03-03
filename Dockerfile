FROM python:latest
MAINTAINER huangwc@easecloud.cn

WORKDIR /var/app

ENV PROJECT=app

COPY ./docker-entrypoint.sh ./

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y

RUN pip install --upgrade pip && pip install gunicorn django greenlet eventlet 
RUN chmod +x docker-entrypoint.sh

VOLUME ["/var/app", "/var/app/media"]

EXPOSE 8000

ENTRYPOINT ["./docker-entrypoint.sh"]

#CMD ["gunicorn", "-b0.0.0.0:8000", "-w4", "-keventlet", "${PROJECT}.wsgi"]

