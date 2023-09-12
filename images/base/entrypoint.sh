#!/bin/sh
set -e
exec "$@"
# Run frp app
frp -c ${FRP_CONFIG_FILE:-/etc/frp/frp.ini}