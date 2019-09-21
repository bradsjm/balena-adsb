#!/bin/sh

set -o errexit          # Exit on most errors (see the manual)
#set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
#set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)

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
