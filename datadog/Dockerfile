FROM achntrl/datadog-agent:latest

ADD *.yaml /etc/datadog-agent/conf.d/

ENV DOCKER_SOCKET_PATH=/var/run/balena.sock \
    DD_APM_ENABLED=false
