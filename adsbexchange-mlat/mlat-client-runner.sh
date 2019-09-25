#!/bin/bash

set -o errexit          # Exit on most errors (see the manual)
set -o nounset          # Disallow expansion of unset variables

echo -n "Connecting ${DUMP1090_SERVER} ${DUMP1090_PORT} .."
while true; do
  (</dev/tcp/${DUMP1090_SERVER}/${DUMP1090_PORT}) > /dev/null 2>&1
  if [ "$?" -eq 0 ]; then
    echo " succeeded"
    break
  else
    echo -n "."
    sleep 1
  fi
done

echo "Connecting to ${DUMP1090_SERVER}:${DUMP1090_PORT} to send to feed.adsbexchange:31090"
mlat-client --input-type 'dump1090' \
            --input-connect "${DUMP1090_SERVER}:${DUMP1090_PORT}" \
            --lat "${LATITUDE}" \
            --lon "${LONGITUDE}" \
            --alt "${ALTITUDE}" \
            --user "${ADSBEXCHANGE_USER}" \
            --server 'feed.adsbexchange.com:31090' \
            --no-udp \
            --results 'beast,listen,30104' \
            "$@"
