#!/bin/sh

set -o errexit          # Exit on most errors (see the manual)
set -o nounset          # Disallow expansion of unset variables

exec rtl_tcp \
    -a 0.0.0.0 \
    -p ${RTLTCP_PORT} ]
    -f ${RTLTCP_FREQUENCY} \
    -g ${RTLTCP_GAIN} \
    -s ${RTLTCP_SAMPLERATE} \
    -d ${RTLTCP_DEVICEINDEX}
