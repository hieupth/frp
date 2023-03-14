#!/bin/sh
set -e
exec "$@"
# execute envsubst script
/bin/sh /scripts/envsubst.sh
# run frp app
frp -c ${FRP_CONFIG_FILE:-/etc/frp/frp.ini}