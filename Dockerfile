FROM registry.access.redhat.com/ubi9/ubi-minimal:9.0.0
# FROM redhat/ubi9/ubi-minimal:9.0.0

LABEL maintainer=""

ENV GO_VERSION=1.18.4

# MicroDNF is recommended over YUM for Building Container Images
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

RUN microdnf --showduplicates list golang | expand

RUN microdnf update -y \
    && microdnf install -y golang-${GO_VERSION} \
    && microdnf clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

# Configure Go Home
RUN mkdir -p $HOME/go \
    && echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc \
    && source $HOME/.bashrc \
    && go env GOPATH

RUN echo "go version: $(go version)"

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
