FROM ubuntu:18.04

ARG TERRAFORM_VERSION="0.14.0"

LABEL terraform_version=${TERRAFORM_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION}

# Installing CircleCI pre-reqs
RUN apt-get update && apt-get install -y apt-utils git gzip tar openssh-server ca-certificates openssl curl zip

# Installing Ansible & Terraform
RUN apt-get update \
    && apt-get install -y ansible unzip \
    && curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip '*.zip' -d /usr/local/bin \
    && rm *.zip

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD    ["/bin/bash"]