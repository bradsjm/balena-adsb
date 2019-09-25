#!/bin/bash

if [ -z "${FLIGHTAWARE_USERNAME}" ]; then
    echo "No FLIGHTAWARE_USERNAME set"
else
    piaware-config "flightaware-user" "${FLIGHTAWARE_USERNAME}"
fi
if [ -z "${FLIGHTAWARE_PASSWORD}" ]; then
    echo "No FLIGHTAWARE_PASSWORD set"
else
    piaware-config "flightaware-password" "${FLIGHTAWARE_PASSWORD}"
fi
if [ -z "${FLIGHTAWARE_FEEDER_ID}" ]; then
    echo "No FLIGHTAWARE_FEEDER_ID set"
else
    piaware-config "feeder-id" "${FLIGHTAWARE_FEEDER_ID}"
fi

if [ -n "${FLIGHTAWARE_GPS_HOST}" ]; then
    echo "GPS_HOST specified, forwarding port 2947 to ${FLIGHTAWARE_GPS_HOST}"
    /usr/bin/socat -s TCP-LISTEN:2947,fork TCP:${FLIGHTAWARE_GPS_HOST}:2947 &
fi

piaware-config "receiver-host" ${DUMP1090_SERVER}
piaware-config "receiver-port" ${DUMP1090_PORT}

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

exec piaware -plainlog