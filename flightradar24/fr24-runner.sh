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

sed -i "s/DUMP1090_SERVER/${DUMP1090_SERVER}/" /etc/fr24feed.ini
sed -i "s/DUMP1090_PORT/${DUMP1090_PORT}/" /etc/fr24feed.ini

exec /usr/bin/fr24feed \
    --config-file=/etc/fr24feed.ini \
    --fr24key=${FR24FEED_KEY}
