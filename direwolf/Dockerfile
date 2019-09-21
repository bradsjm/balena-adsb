# Base image to use
ARG IMAGE=balenalib/raspberrypi3-alpine

# Run Image
FROM ${IMAGE}:build as build

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    install_packages \
    rtl-sdr@testing \
    hamlib@testing \
    gpsd \
    alsa-lib

RUN install_packages \
    git build-base cmake \
    hamlib-dev@testing \
    libc-dev \
    gpsd-dev \
    alsa-lib-dev \
    linux-headers

RUN git clone "https://github.com/wb2osz/direwolf.git" /tmp/direwolf && \
    echo "#include <unistd.h>" > /usr/include/sys/unistd.h && \
    cd /tmp/direwolf && \
    sed -i 's/--mode=/-m /g' Makefile.linux && \
    sed -i 's/cp -n/cp/g' Makefile.linux && \
    CFLAGS=-D__FreeBSD__ make && make DESTDIR=/target install && \
    find /target/bin -type f -exec strip -p --strip-debug {} \;

# Run Image
FROM ${IMAGE}:run

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    install_packages \
    tini \
    rtl-sdr@testing \
    hamlib@testing \
    gpsd \
    alsa-lib

COPY --from=build /target/ /usr/local/
COPY --from=build /etc/udev/rules.d/99-direwolf-cmedia.rules /etc/udev/rules.d/99-direwolf-cmedia.rules

ENV MYCALL n0call \
    IGSERVER noam.aprs2.net \
    IGLOGIN n0call -1 \
    FREQUENCY 144.39M \
    DEVICE 1

EXPOSE 8000 8001

ADD sdr.conf /etc/sdr.conf
ADD direwolf-runner.sh /usr/local/bin/direwolf-runner

ENTRYPOINT [ "tini", "--" ]
CMD ["direwolf-runner"]