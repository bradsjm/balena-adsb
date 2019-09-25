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

exec modesmixer2 --web 8080 \
            --inConnectId "${DUMP1090_SERVER}:${DUMP1090_PORT}:DUMP1090" \
            --inConnectId "adsbexchange-mlat:30104:ADSBEXCH" \
            --inConnectId "flightaware:30105:FLTAWARE" \
            --location "${LATITUDE}:${LONGITUDE}" \
            --google-key "${GOOGLE_KEY}" \
            ${@}
