#!/bin/sh
set -e
exec "$@"
# Save decrypt password.
echo "$PASSWORD" > password
# Pull certs git repo if exist.
if [[ -z "${TLS_GIT_REPO}" ]]; then
  if cd /certs; then git pull; else git clone ${TLS_GIT_REPO} /certs; fi
  ansible-vault decrypt --vault-password-file password \
    /certs/${FRP_HOST_DOMAIN}/fullchain.pem \
    /certs/${FRP_HOST_DOMAIN}/privkey.pem \
    /certs/${FRP_HOST_DOMAIN}/cert.pem \
    /certs/${FRP_HOST_DOMAIN}/chain.pem \
    /certs/${FRP_HOST_DOMAIN}/concat.pem 
fi 
# Run frp app
frp -c ${FRP_CONFIG_FILE:-/etc/frp/frp.ini}