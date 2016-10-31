FROM python:latest
MAINTAINER huangwc@easecloud.cn

WORKDIR /var/app

ENV PROJECT=app

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y

COPY ./startup.sh /var
ADD ./build.sh /var
ADD ./requirements.txt /var

RUN chmod +x /var/startup.sh && chmod +x /var/build.sh
RUN /var/build.sh

VOLUME ["/var/app", "/var/app/media"]

EXPOSE 8000

CMD ["/var/startup.sh"]


