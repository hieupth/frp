#!/bin/sh
set -e
exec "$@"
# Run FRP app.
frp -c ${FRP_CONFIG_FILE:-/etc/frp/frp.toml}