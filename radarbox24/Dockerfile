# Base image to use
ARG IMAGE=balenalib/raspberrypi3-debian

FROM ${IMAGE}:build as build

RUN bash -c "$(wget -O - http://apt.rb24.com/inst_rbfeeder.sh)"

FROM ${IMAGE}:run

ENV DUMP1090_HOST=dump1090
ENV DUMP1090_PORT=30005
ENV DUMP1090_PROTOCOL=beast
ENV RADARBOX24_KEY=

EXPOSE 32088

RUN install_packages dumb-init librtlsdr0 libcurl4-gnutls-dev libglib2.0-0
COPY --from=build /usr/bin/rbfeeder /usr/bin/rbfeeder
COPY --from=build /etc/rbfeeder.ini /etc/rbfeeder.ini
COPY radarbox24-client.sh /usr/local/bin/radarbox24-client

ENTRYPOINT ["dumb-init", "--"]
CMD ["radarbox24-client"]