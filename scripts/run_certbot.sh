#!/bin/bash

/opt/certbot/venv/bin/certbot renew >> /var/log/letsencrypt.log

for i in /etc/letsencrypt/live/* ; do
  if [ -d "$i" ]; then
    cat $i/fullchain.pem $i/privkey.pem > /certs/$(basename "$i").pem
  fi
done
