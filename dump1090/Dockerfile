# Base image to use
ARG IMAGE=balenalib/raspberrypi3-alpine

# Builder Image
FROM ${IMAGE}:build as build
ARG DUMP1090_VERSION=master

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN install_packages \
    tini \
    librtlsdr@testing \
    libusb \
    ncurses-libs

RUN install_packages \
    curl ca-certificates \
    coreutils make gcc pkgconf \
    ncurses-dev \
    libc-dev librtlsdr-dev@testing libusb-dev

RUN curl -Ls --output "dump1090-fa.tar.gz" "https://codeload.github.com/flightaware/dump1090/tar.gz/${DUMP1090_VERSION}"
RUN tar -xvf ../dump1090-fa.tar.gz --strip-components=1 && cd dump1090-${DUMP1090_VERSION}
RUN make BLADERF=no DUMP1090_VERSION="${DUMP1090_VERSION}"
RUN make BLADERF=no test

# Final Image
FROM ${IMAGE}:run

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN install_packages \
    tini \
    librtlsdr@testing \
    libusb \
    ncurses-libs

COPY --from=build /dump1090/dump1090 /usr/local/bin/dump1090

# Raw output
EXPOSE 30002/tcp
# Basestation output
EXPOSE 30003/tcp
# Beast output
EXPOSE 30005/tcp

ENTRYPOINT ["tini", "--", "nice", "-n", "-5", "dump1090", "--net", "--net-bind-address", "0.0.0.0", "--debug", "n", "--mlat", "--net-heartbeat", "5", "--quiet", "--stats-every", "60"]
