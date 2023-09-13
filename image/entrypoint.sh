#!/bin/sh
set -e
exec "$@"
# Fetch and decrypt certs.
sh /usr/local/bin/gitfetch.sh
# Run FRP app.
frp -c ${FRP_CONFIG_FILE:-/etc/frp/frp.toml}