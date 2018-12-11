FROM  golang:1.10-alpine3.7 as builder
MAINTAINER Iurii Medvedev <medvedev.yp@gmail.com>

RUN apk add --no-cache --virtual .build-deps \
    git \
    gcc \
    libc-dev \
    gpgme-dev && \
    go get github.com/openshift/origin/cmd/oc && \
    apk del .build-deps

FROM alpine:latest
RUN apk --no-cache add ca-certificates gpgme
WORKDIR /root/
COPY --from=builder /go/bin/oc /usr/bin/

WORKDIR /root
