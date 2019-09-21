#!/bin/sh

set -o errexit          # Exit on most errors (see the manual)
#set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
#set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)

modesmixer2 --web 8080 \
            --inConnectId "${DUMP1090_SERVER}:${DUMP1090_PORT}:DUMP1090" \
            --inConnectId "flightaware:30105:MLAT" \
            --location "${LATITUDE}:${LONGITUDE}" \
            --google-key "${GOOGLE_KEY}" \
            "$@"
