# Base image to use
ARG IMAGE=balenalib/raspberrypi3-alpine

FROM ${IMAGE}:run

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN install_packages \
    dumb-init \
    rtl-sdr@testing

COPY rtl_tcp-runner.sh /usr/local/bin/rtl_tcp-runner

ENV RTLTCP_DEVICEINDEX=0 \
    RTLTCP_PORT=1234 \
    RTLTCP_GAIN=0 \
    RTLTCP_FRQUENCY=100000000 \
    RTLTCP_SAMPLERATE=2048000

# Raw output
EXPOSE 1234/tcp

# Entrypoint
ENTRYPOINT ["dumb-init", "--"]
CMD ["rtl_tcp-runner"]
