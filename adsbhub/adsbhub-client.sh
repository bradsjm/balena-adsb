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

while true; do
  echo "Starting replay from TCP:${DUMP1090_SERVER}:${DUMP1090_PORT} to TCP:data.adsbhub.org:5001"

  set +o errexit
  socat -d -d -u "TCP:${DUMP1090_SERVER}:${DUMP1090_PORT}" 'TCP:data.adsbhub.org:5001'
  SOCAT_STATUS=${?}
  set -o errexit

  echo "Replay ended"

  if [[ "${SOCAT_STATUS}" -eq 0 ]]; then
    echo "Replay ended without failure"
    break
  else
    echo "Replay ended with failure (${SOCAT_STATUS}) - restarting"
  fi
done

exit ${SOCAT_STATUS}
