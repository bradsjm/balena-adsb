# Base image to use
ARG IMAGE=balenalib/raspberrypi3-debian

FROM ${IMAGE}:run

ARG PFCLIENT_VERSION=4.1.1

# Find the lastest version @ https://planefinder.net/sharing/client
# With the changelog @ https://planefinder.net/sharing/client_changelog
RUN install_packages curl ca-certificates iputils-ping libc-bin libc-dbg

RUN curl -Ls --output pfclient.tar.gz "http://client.planefinder.net/pfclient_${PFCLIENT_VERSION}_armhf.tar.gz" | tar -xzC /usr/local/bin pfclient

COPY pfclient-runner.sh /usr/local/bin/pfclient-runner
COPY pfclient-config.json /etc/pfclient-config.json

EXPOSE 30053

HEALTHCHECK --start-period=1m --interval=30s --timeout=5s --retries=3 CMD curl --silent --fail --show-error -o /dev/null http://localhost:30053/ || exit 1

ENTRYPOINT ["pfclient-runner"]
