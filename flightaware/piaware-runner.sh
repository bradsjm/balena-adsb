#!/bin/sh

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

exec piaware -plainlog