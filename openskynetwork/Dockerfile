# Base image to use
ARG IMAGE=balenalib/raspberrypi3-debian

FROM ${IMAGE}:run

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    dumb-init netbase gnupg2 ca-certificates apt-transport-https wget && \
    wget -qO - https://opensky-network.org/files/firmware/opensky.gpg.pub | apt-key add - && \
    echo 'deb https://opensky-network.org/repos/debian opensky custom' > /etc/apt/sources.list.d/opensky.list && \
    apt-get update -y && \
    echo "opensky-feeder openskyd/latitude string 1" | debconf-set-selections && \
    echo "opensky-feeder openskyd/longitude string 1" | debconf-set-selections && \
    echo "opensky-feeder openskyd/altitude string 1" | debconf-set-selections && \
    echo "opensky-feeder openskyd/username string" | debconf-set-selections && \
    echo "opensky-feeder openskyd/serial string" | debconf-set-selections && \
    echo "opensky-feeder openskyd/host string" | debconf-set-selections && \
    echo "opensky-feeder openskyd/port string" | debconf-set-selections && \
    echo "opensky-feeder openskyd/dump1090branch string default" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends opensky-feeder && \
    apt-get purge -y dirmngr gnupg2 ca-certificates apt-transport-https && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf ~/.gnupg /var/lib/apt/lists/* /etc/apt/sources.list.d/opensky.list

ENV OPENSKY_LATITUDE= \
    OPENSKY_LONGITUDE= \
    OPENSKY_ALTITUDE= \
    OPENSKY_USER= \
    OPENSKY_SERIAL= \
    DUMP1090_HOST=dump1090 \
    DUMP1090_PORT=30005

EXPOSE 32088

COPY openskynetwork-client.sh /
ENTRYPOINT ["dumb-init", "--"]
CMD ["/bin/sh", "openskynetwork-client.sh"]
