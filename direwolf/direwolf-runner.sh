#!/bin/sh

# Update configuration using environment variables
if [ -n "$MYCALL" ]; then
  sed -i 's|^MYCALL.*$|MYCALL '"$MYCALL"'|g' /etc/sdr.conf
fi

if [ -n "$IGSERVER" ]; then
  sed -i 's|^IGSERVER.*$|IGSERVER '"$IGSERVER"'|g' /etc/sdr.conf
fi

if [ -n "$IGLOGIN" ]; then
  sed -i 's|^IGLOGIN.*$|IGLOGIN '"$IGLOGIN"'|g' /etc/sdr.conf
fi

# Start Direwolf
rtl_fm -f ${FREQUENCY} -d ${DEVICE} ${*} - | direwolf -c /etc/sdr.conf -t 0 -r 24000 -D 1 -t 0 -a 60 -