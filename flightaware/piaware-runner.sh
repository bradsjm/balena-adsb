#!/bin/sh

set -o errexit          # Exit on most errors (see the manual)
#set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
#set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)


echo "Waiting for dump1090 to start up"
sleep 5s

echo
echo "FLIGHTAWARE_USERNAME=${FLIGHTAWARE_USERNAME}"
echo "FLIGHTAWARE_PASSWORD=***"
echo "FLIGHTAWARE_FEEDER_ID=${FLIGHTAWARE_FEEDER_ID}"
echo "FLIGHTAWARE_GPS_HOST=${FLIGHTAWARE_GPS_HOST}"
echo


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

piaware -plainlog

exit ${?}
