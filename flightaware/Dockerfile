# Base image to use
ARG IMAGE=balenalib/raspberrypi3-debian

FROM ${IMAGE}:run

ARG PIAWARE_VERSION=3.7.1

ADD http://flightaware.com/adsb/piaware/files/packages/pool/piaware/p/piaware-support/piaware-repository_${PIAWARE_VERSION}_all.deb /

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8
RUN dpkg -i /piaware-repository_${PIAWARE_VERSION}_all.deb && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends piaware dumb-init && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /piaware-repository_${PIAWARE_VERSION}_all.deb /var/lib/apt/lists/*

COPY piaware.conf /etc/piaware.conf
COPY piaware-runner.sh /usr/local/bin/piaware-runner

EXPOSE 30105/tcp

ENTRYPOINT ["dumb-init", "--"]
CMD ["piaware-runner"]