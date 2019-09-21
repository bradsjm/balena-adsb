#!/bin/bash

set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)


function start_secion_spacer {
    echo '=============================='
    echo "======== ${1}"
    echo '=============================='
}

function end_secion_spacer {
    echo '=============================='
    echo
}

start_secion_spacer "Running with"
echo " - DUMP1090_SERVER=${DUMP1090_SERVER}"
echo " - DUMP1090_PORT=${DUMP1090_PORT}"
echo " - PLANEFINDER_SHARECODE=${PLANEFINDER_SHARECODE}"
echo " - PLANEFINDER_LATITUDE =${LATITUDE}"
echo " - PLANEFINDER_LONGITUDE=${LONGITUDE}"
end_secion_spacer

start_secion_spacer 'pfclient-config.json template'
cat /etc/pfclient-config.json
end_secion_spacer

start_secion_spacer 'customising config'
sed -i "s/DUMP1090_SERVER/${DUMP1090_SERVER}/" /etc/pfclient-config.json
sed -i "s/DUMP1090_PORT/${DUMP1090_PORT}/" /etc/pfclient-config.json
sed -i "s/PLANEFINDER_SHARECODE/${PLANEFINDER_SHARECODE}/" /etc/pfclient-config.json
sed -i "s/PLANEFINDER_LATITUDE/${LATITUDE}/" /etc/pfclient-config.json
sed -i "s/PLANEFINDER_LONGITUDE/${LONGITUDE}/" /etc/pfclient-config.json
end_secion_spacer

start_secion_spacer "pfclient-config.json customised"
cat /etc/pfclient-config.json
end_secion_spacer

start_secion_spacer 'pfclient version'
pfclient --version
end_secion_spacer

start_secion_spacer 'Starting pfclient'
set +o errexit
catchsegv pfclient --config_path=/etc/pfclient-config.json --log_path=/var/log
PFCLIENT_STATUS=${?}
set -o errexit

if [[ "${PFCLIENT_STATUS}" -eq 0 ]]; then
    echo "pfclient ended without failure"
else
    echo "pfclient ended with failure (${PFCLIENT_STATUS})"
fi
end_secion_spacer

exit ${PFCLIENT_STATUS}
