FROM alpine:3.11

LABEL maintainer="Ángel Prada <root@angelprada.com>"

ARG rpmrebuild_version=2.14

RUN apk add --no-cache bash coreutils curl make rpm shadow && \
    mkdir /build && \
    curl -L -o /build/rpmrebuild.tgz https://netcologne.dl.sourceforge.net/project/rpmrebuild/rpmrebuild/${rpmrebuild_version}/rpmrebuild-${rpmrebuild_version}.tar.gz  && \
    cd /build && tar xfvz rpmrebuild.tgz && make && make install && \
    cd / && rm -rf /build

RUN useradd builder

USER builder
ENTRYPOINT [ "/usr/bin/rpmrebuild" ]