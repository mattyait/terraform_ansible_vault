FROM golang:alpine

ENV TERRAFORM_VERSION=0.12.6

RUN apk add --update git bash openssh && \
    apk add vim curl

RUN apk add py-pip && \
    pip install --upgrade pip && \
    pip install awscli

RUN apk add jq && \
    apk add ansible

RUN wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && mv terraform /usr/bin \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR /mnt
