# Base image to use
ARG IMAGE=balenalib/raspberrypi3-alpine

# Run Image
FROM ${IMAGE}:run

RUN install_packages socat iputils

COPY adsbexchange-client.sh /usr/local/bin/adsbexchange-client

ENTRYPOINT ["adsbexchange-client"]
