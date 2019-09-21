# Base image to use
ARG IMAGE=balenalib/raspberrypi3-debian

FROM ${IMAGE}:run

RUN install_packages netbase curl openssl ca-certificates sqlite3 dumb-init

RUN curl -Ls "https://drive.google.com/uc?export=download&id=1lV_tUMVIj_CvM3kxdkk8PX2pLLAJskw_" | tar -xzC /usr/local/bin modesmixer2

EXPOSE 8080

HEALTHCHECK --start-period=1m --interval=30s --timeout=5s --retries=3 CMD curl --silent --show-error -o /dev/null --fail http://localhost:8080/ || exit 1

COPY modesmixer2-runner.sh /usr/local/bin/modesmixer2-runner

ENTRYPOINT ["dumb-init", "--"]
CMD ["modesmixer2-runner"]
