# Base image to use
ARG IMAGE=balenalib/raspberrypi3-alpine

# Run Image
FROM ${IMAGE}:run

RUN install_packages tini socat iputils

COPY adsbhub-client.sh /usr/local/bin/adsbhub-client
ENTRYPOINT ["tini", "--"]
CMD ["adsbhub-client"]