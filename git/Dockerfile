FROM python:alpine
MAINTAINER James Dalton <tarpdalton@gmail.com>

# update and install basic tools
RUN apk add --update git \
  && rm -rf /var/cache/apk/*

RUN pip install gitpython requests kafka-python

ADD parsegitlog.py /tmp/
ADD config.ini /tmp/

WORKDIR /tmp/
