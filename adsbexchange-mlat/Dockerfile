# Base image to use
ARG IMAGE=balenalib/raspberrypi3-alpine

# Run Image
FROM ${IMAGE}:build as build

ARG MLAT_CLIENT_VERSION=master

RUN install_packages python3 git build-base curl ca-certificates python3-dev
RUN pip3 install --upgrade shiv importlib-resources==0.8

RUN curl -Ls --output mlat-client.tar.gz "https://github.com/mutability/mlat-client/archive/${MLAT_CLIENT_VERSION}.tar.gz"
RUN shiv -c mlat-client -o /usr/local/bin/mlat-client /mlat-client.tar.gz

FROM ${IMAGE}:run

RUN install_packages python3 && \
    rm -rf /usr/share/terminfo

COPY --from=build /usr/local/bin/mlat-client /usr/local/bin/mlat-client
COPY mlat-client-runner.sh /usr/bin/mlat-client-runner

ENV SHIV_ROOT=/tmp
EXPOSE 30104/tcp
ENTRYPOINT ["mlat-client-runner"]
