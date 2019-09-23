FROM balenalib/raspberrypi3-alpine-python:2.7

# Install Glances (develop branch)
RUN apk add --no-cache --virtual .build_deps \
    gcc \
    musl-dev \
    linux-headers \
    && pip install future wifi 'docker>=2.0.0' 'psutil>=5.4.7,<5.5.0' bottle==0.12.13 \
    && apk del .build_deps
RUN apk add --no-cache dumb-init wireless-tools git \
    && git clone -b develop https://github.com/nicolargo/glances.git

# Define working directory.
WORKDIR /glances
ADD glances.conf /glances/conf/glances.conf

# EXPOSE PORT (For Web UI & XMLRPC)
EXPOSE 61208 61209

# Define default command.
ENTRYPOINT [ "dumb-init", "--" ]
CMD python -m glances -C /glances/conf/glances.conf $GLANCES_OPT
