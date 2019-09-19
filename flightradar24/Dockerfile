# Base image to use
ARG IMAGE=balenalib/raspberrypi3-debian

FROM ${IMAGE}:run

ARG FR24FEED_VERSION=1.0.24-1
ENV FR24FEED_KEY=

# Find the laest version @ http://repo.feed.flightradar24.com/ searching for "rpi_binaries/fr24feed_*_armhf.tgz"
# With the changelog @ http://repo.feed.flightradar24.com/CHANGELOG.md
RUN install_packages curl ca-certificates iputils-ping dnsutils

RUN curl -Ls --output fr24feed.tgz "http://repo.feed.flightradar24.com/rpi_binaries/fr24feed_${FR24FEED_VERSION}_armhf.tgz" && \
    tar -xvf fr24feed.tgz --strip-components=1 fr24feed_armhf/fr24feed && \
    mv fr24feed /usr/bin/fr24feed && \
    rm fr24feed.tgz

# https://feed.flightradar24.com/fr24feed-manual.pdf
COPY fr24feed.ini /etc/fr24feed.ini

EXPOSE 8754/tcp

HEALTHCHECK --start-period=1m --interval=30s --timeout=5s --retries=3 CMD curl --silent --fail --show-error -o /dev/null http://localhost:8754/ || exit 1

CMD [ "/usr/bin/fr24feed", "--config-file=/etc/fr24feed.ini", "--fr24key=${FR24FEED_KEY}" ]
