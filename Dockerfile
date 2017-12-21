FROM jenkins/jnlp-slave

LABEL maintainer="Deepu Mohan Puthrote <git@deepumohan.com>"

USER root

ENV PYTHON_VERSION 3.5
ENV DOCKER_VERSION 17.06.2~ce-0~debian

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get -y install \
       build-essential \
       libffi-dev \
       libpq-dev \
       libssl-dev \
       python${PYTHON_VERSION} \
       python3-dev \
       python3-pip \
       python3-setuptools \
       python3-venv \
       python3-wheel \
    && ln -nsf /usr/bin/python3.5 /usr/bin/python \
    && apt-get -y install \
       apt-transport-https \
       ca-certificates \
       curl \
       gnupg2 \
       software-properties-common \
    && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get -y install \
       docker-ce=${DOCKER_VERSION} \
    && rm -rf /var/lib/apt/lists/* \
    && apt -y remove \
       apt-transport-https \
       ca-certificates \
       curl \
       gnupg2

USER jenkins
