# Base image to use
ARG IMAGE=balenalib/raspberrypi3-alpine

# Builder Image
FROM ${IMAGE}:build as build
ARG DUMP1090_VERSION=master

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN install_packages \
    librtlsdr@testing \
    libusb \
    ncurses-libs

RUN install_packages \
    curl ca-certificates \
    coreutils make gcc pkgconf \
    ncurses-dev \
    libc-dev librtlsdr-dev@testing libusb-dev

RUN mkdir /build && \
    cd /build && \
    curl -Ls --output "dump1090-fa.tar.gz" "https://codeload.github.com/flightaware/dump1090/tar.gz/${DUMP1090_VERSION}" && \
    tar -xvf "dump1090-fa.tar.gz" --strip-components=1 && \
    make BLADERF=no DUMP1090_VERSION="${DUMP1090_VERSION}" && \
    make BLADERF=no test && \
    strip -ps dump1090

# Final Image
FROM ${IMAGE}:run

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN install_packages \
    dumb-init \
    librtlsdr@testing \
    libusb \
    ncurses-libs

COPY --from=build /build/dump1090 /usr/local/bin/dump1090
COPY dump1090-runner.sh /usr/local/bin/dump1090-runner

# Raw output
EXPOSE 30002/tcp
# Basestation output
EXPOSE 30003/tcp
# Beast output
EXPOSE 30005/tcp

ENV DEVICE="0" \
    LATITUDE=\
    LONGITUDE=\
    RECEIVER_OPTIONS="--gain -10 --ppm 0" \
    DECODER_OPTIONS="--max-range 360 --quiet --stats-range --stats-every 60" \
    NET_OPTIONS="--net --net-heartbeat 60 --net-ro-size 1000 --net-ro-interval 1 --net-ri-port 0 --net-ro-port 30002 --net-sbs-port 30003 --net-bo-port 30005"

# Entrypoint
ENTRYPOINT ["dumb-init", "--"]
CMD ["dump1090-runner"]
