FROM ubuntu:22.10

LABEL maintainer=""

ENV GO_VERSION=1.19.3
ENV GO_URL=https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz

RUN apt update -y && apt upgrade -y \
    && apt install -y gzip \
    && apt install -y tar \
    && apt install -y wget \
    && apt install -y curl \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

# Download and install Go
RUN wget ${GO_URL} \ 
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz

# Configure Go Home
ENV GOROOT=/usr/local/go 
ENV GOPATH=$HOME/go
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH 

RUN echo "go version: $(go version)" \
    && echo "wget version: $(wget --version | head -n 1)" \
    && echo "tar version: $(tar --version | head -n 1)" \
    && echo "gzip version: $(gzip --version | head -n 1)"

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
