FROM balenalib/raspberrypi3-alpine-python:2.7

# Install Glances (develop branch)
RUN apk add --no-cache --virtual .build_deps \
    gcc \
    musl-dev \
    linux-headers \
    && pip install future 'psutil>=5.4.7,<5.5.0' bottle==0.12.13 \
    && apk del .build_deps
RUN apk add --no-cache git && git clone -b develop https://github.com/nicolargo/glances.git

# Define working directory.
WORKDIR /glances

# EXPOSE PORT (For Web UI & XMLRPC)
EXPOSE 61208 61209

# Define default command.
CMD python -m glances -C /glances/conf/glances.conf $GLANCES_OPT
