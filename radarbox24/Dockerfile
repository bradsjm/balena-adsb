ARG ARCH=armhf
FROM multiarch/debian-debootstrap:${ARCH}-stretch-slim

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    dumb-init netbase dirmngr gnupg2 ca-certificates apt-transport-https && \
    mkdir ~/.gnupg && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 1D043681 && \
    echo 'deb https://apt.rb24.com/ rpi-stable main' > /etc/apt/sources.list.d/rb24.list && \
    apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends rbfeeder && \
    apt-get purge -y dirmngr gnupg2 ca-certificates apt-transport-https libssl1.1 openssl && \
    apt-get clean && \
    rm -rf ~/.gnupg /var/lib/apt/lists/* /etc/apt/sources.list.d/rb24.list

ENV DUMP1090_HOST=dump1090
ENV DUMP1090_PORT=30005
ENV DUMP1090_PROTOCOL=beast
ENV RADARBOX24_KEY=

EXPOSE 32088

COPY radarbox24-client.sh /
ENTRYPOINT ["dumb-init", "--", "/bin/sh","radarbox24-client.sh"]

# Metadata
ARG VCS_REF="Unknown"
LABEL maintainer="jb@nrgup.net" \
      org.label-schema.name="Docker ADS-B - Radarbox24" \
      org.label-schema.description="Docker container for ADS-B - This is the RBFeeder component" \
      org.label-schema.url="https://github.com/bradsjm/docker-ads-b" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="https://github.com/bradsjm/docker-ads-b" \
      org.label-schema.schema-version="1.0"
