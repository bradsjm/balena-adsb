# Base image to use
ARG IMAGE=balenalib/raspberrypi3-alpine

FROM ${IMAGE}:build as build

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN install_packages \
    dumb-init \
    librtlsdr@testing \
    libusb

RUN install_packages \
    git build-base cmake \
    librtlsdr-dev@testing \
    libc-dev \
    libusb-dev

RUN git clone "https://github.com/merbanan/rtl_433.git" /tmp/rtl_433 && \
    mkdir -p /tmp/rtl_433/build && \
    cd /tmp/rtl_433/build && \
    cmake .. && \
    make && \
    make install && \
    strip -p --strip-debug /usr/local/bin/rtl_433

FROM ${IMAGE}:run

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN install_packages \
    dumb-init \
    librtlsdr@testing \
    libusb

COPY --from=build /usr/local/bin/rtl_433 /usr/local/bin/rtl_433
COPY --from=build /usr/local/etc/rtl_433/* /usr/local/etc/rtl_433/

ENTRYPOINT ["dumb-init", "--", "/usr/local/bin/rtl_433"]
