# Base image to use
ARG IMAGE=balenalib/raspberrypi3-alpine

# Run Image
FROM ${IMAGE}:run

RUN install_packages dumb-init socat
COPY adsbexchange-client.sh /usr/local/bin/adsbexchange-client

ENV ADSBEXCHANGE_PORT=30005 \
    DUMP1090_PORT=30005\
    DUMP1090_SERVER=dump1090

ENTRYPOINT ["dumb-init", "--"]
CMD ["adsbexchange-client"]