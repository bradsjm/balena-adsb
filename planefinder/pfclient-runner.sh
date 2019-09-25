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

sed -i "s/DUMP1090_SERVER/${DUMP1090_SERVER}/" /etc/pfclient-config.json
sed -i "s/DUMP1090_PORT/${DUMP1090_PORT}/" /etc/pfclient-config.json
sed -i "s/PLANEFINDER_SHARECODE/${PLANEFINDER_SHARECODE}/" /etc/pfclient-config.json
sed -i "s/PLANEFINDER_LATITUDE/${LATITUDE}/" /etc/pfclient-config.json
sed -i "s/PLANEFINDER_LONGITUDE/${LONGITUDE}/" /etc/pfclient-config.json

exec pfclient \
    --config_path=/etc/pfclient-config.json \
    --log_path=/var/log
    ${@}
