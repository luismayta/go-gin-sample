FROM python:3.6.4-alpine

MAINTAINER Luis Mayta <@slovacus>

LABEL NAME go-gin-sample-check
LABEL VERSION 0.0.0

COPY ./requirements/ /usr/src/requirements/
COPY ./requirements.txt /usr/src/requirements.txt

# set working directory to /usr/src/
WORKDIR /usr/src/

RUN apk add --update --no-cache --virtual .fetch-deps \
    build-base \
    openssl-dev libffi-dev \
    ca-certificates  \
    git curl openssl wget \
    # Install shellcheck
    && wget https://storage.googleapis.com/shellcheck/shellcheck-latest.linux.x86_64.tar.xz \
    && tar xvfJ shellcheck-latest.linux.x86_64.tar.xz \
    && chmod +x shellcheck-latest/shellcheck \
    && mv shellcheck-latest/shellcheck /usr/bin/shellcheck \
    && rm shellcheck-latest.linux.x86_64.tar.xz \
    && rm -rf shellcheck-latest \
    # install python dependencies
    && pip install -r /usr/src/requirements/setup.txt \
    # Clean files unnecesary
    && rm -rf /var/cache/apk/*
