FROM registry.access.redhat.com/ubi9/ubi-minimal:9.0.0
# FROM redhat/ubi9/ubi-minimal:9.0.0

LABEL maintainer=""

# MicroDNF is recommended over YUM for Building Container Images
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

RUN microdnf update -y \
    && microdnf install -y golang1.18.4 \
    && microdnf clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

RUN echo "go version: $(go version)"

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
