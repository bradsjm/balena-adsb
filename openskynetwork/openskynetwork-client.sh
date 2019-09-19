#!/bin/sh
set -x
echo "opensky-feeder openskyd/latitude string ${LATITUDE}" | debconf-set-selections
echo "opensky-feeder openskyd/longitude string ${LONGITUDE}" | debconf-set-selections
echo "opensky-feeder openskyd/altitude string ${ALTITUDE}" | debconf-set-selections
echo "opensky-feeder openskyd/username string ${OPENSKY_USER}" | debconf-set-selections
echo "opensky-feeder openskyd/serial string ${OPENSKY_SERIAL}" | debconf-set-selections
echo "opensky-feeder openskyd/host string ${DUMP1090_HOST}" | debconf-set-selections
echo "opensky-feeder openskyd/port string ${DUMP1090_PORT}" | debconf-set-selections
echo "opensky-feeder openskyd/dump1090branch string default" | debconf-set-selections
dpkg-reconfigure -u opensky-feeder

exec /usr/bin/openskyd-dump1090