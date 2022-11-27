FROM registry.access.redhat.com/ubi9/ubi-minimal:9.0.0
# FROM redhat/ubi9/ubi-minimal:9.0.0

LABEL maintainer=""

ENV GO_VERSION=1.19.3
ENV GO_URL=https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz

# MicroDNF is recommended over YUM for Building Container Images
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

RUN microdnf --showduplicates list golang | expand

RUN microdnf update -y \
    && microdnf install -y tar \
    && microdnf install -y wget \
    && microdnf clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

# Download and install Go
RUN wget ${GO_URL} \ 
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz

# Configure Go Home
ENV GOROOT=/usr/local/go 
ENV GOPATH=$HOME/go
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH 

RUN echo "go version: $(go version)" \
    && echo "wget version: $(wget --version)" \
    && echo "tar version: $(tar --version)"

USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
