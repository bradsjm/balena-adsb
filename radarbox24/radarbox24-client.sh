#!/bin/sh
#set -x
exec /usr/bin/rbfeeder \
  --setkey ${RADARBOX24_KEY} \
  --set-network-mode on \
  --set-network-host $(getent hosts ${DUMP1090_HOST} | head -n 1 | awk '{print $1}') \
  --set-network-port ${DUMP1090_PORT} \
  --set-network-protocol ${DUMP1090_PROTOCOL} \
  ${@}