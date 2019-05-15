FROM node:8-stretch-slim
MAINTAINER Paul Queruel <paul.queruel@viacesi.fr>

ENV \
    RUNTIME_DEPS="gettext python-pip tar bash unzip curl git openssh-client ca-certificates apt-transport-https gnupg2 software-properties-common gnupg2"

RUN \
    apt-get update && \
    apt-get install -y $RUNTIME_DEPS && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst

# Install Docker
RUN \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Install docker-compose
RUN \
    curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Install Yarn
RUN \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && \
    apt install --no-install-recommends -y yarn

# Install Jest
RUN \
    yarn global add jest

RUN \
    apt-get clean && \
    apt-get autoremove -y
