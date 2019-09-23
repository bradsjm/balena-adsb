FROM balenalib/raspberrypi3-alpine

RUN install_packages dumb-init python3 wireless-tools
RUN apk add --no-cache --virtual .build_deps \
    gcc \
    musl-dev \
    linux-headers \
    python3-dev \
    && pip3 install --no-cache \
    influxdb>=1.0.0 \
    glances[cpuinfo,docker,ip,web,wifi] \
    && apk del .build_deps

# Define working directory.
WORKDIR /glances
ADD glances.conf /glances/conf/glances.conf

# Configuration volume
VOLUME /glances/conf

# Command line options
ENV GLANCES_OPT=-w

# EXPOSE PORT (For Web UI & XMLRPC)
EXPOSE 61208 61209

# Define default command.
ENTRYPOINT [ "dumb-init", "--" ]
CMD python3 -m glances -C /glances/conf/glances.conf $GLANCES_OPT
