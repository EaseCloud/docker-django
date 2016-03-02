FROM python:latest
MAINTAINER huangwc@easecloud.cn

ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get upgrade -y

RUN pip install --upgrade pip
RUN pip install gunicorn django greenlet eventlet gevent 
RUN mkdir -p /var/www/ && cd /var/www
RUN django-admin startproject pytest
RUN cd pytest

EXPOSE 8000

CMD ["gunicorn", "--chdir /var/www/pytest", "-b 0.0.0.0:8000", "-w 4", "-k eventlet", "pytest.wsgi"]


