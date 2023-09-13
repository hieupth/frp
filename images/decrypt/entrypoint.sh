#!/bin/sh
set -e
exec "$@"
# Save decrypt password.
echo "$PASSWORD" > /password
# Pull certs git repo if exist.
if [[ -z "${TLS_GIT_REPO}" ]] 
then
  echo "Ignore git"
else
  echo "Git clone: ${TLS_GIT_REPO}"
  if cd /ssl 
  then 
    git pull 
  else 
    cd /
    git clone ${TLS_GIT_REPO} /ssl 
  fi
fi  
# Ansible decrypt certs.
ansible-vault decrypt --vault-password-file /password \
  /ssl/certs/${FRP_HOST_DOMAIN}/fullchain.pem \
  /ssl/certs/${FRP_HOST_DOMAIN}/privkey.pem \
  /ssl/certs/${FRP_HOST_DOMAIN}/cert.pem \
  /ssl/certs/${FRP_HOST_DOMAIN}/chain.pem \
  /ssl/certs/${FRP_HOST_DOMAIN}/concat.pem 
# Fix certs permission.
chmod 600 /ssl/certs/${FRP_HOST_DOMAIN}/*.pem
# Run frp app
frp -c ${FRP_CONFIG_FILE:-/etc/frp/frp.ini}