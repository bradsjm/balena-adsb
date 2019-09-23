# Base image to use
ARG IMAGE=balenalib/raspberrypi3-alpine

# Run Image
FROM ${IMAGE}:run

RUN install_packages dumb-init socat iputils

COPY adsbhub-client.sh /usr/local/bin/adsbhub-client
ENTRYPOINT ["dumb-init", "--"]
CMD ["adsbhub-client"]