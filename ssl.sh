#!/usr/bin/env bash
source .env

# run caddy once and wait for certificate logs
mkdir -p ./conf/ssl/
docker rm -f rtmpcaddy
docker run -v ./caddy_data:/data --name rtmpcaddy -p 80:80 -p 443:443 caddy caddy reverse-proxy --from $RTMP_HOSTNAME --to http://localhost

# copy cert to ssl path
cat ./caddy_data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/$RTMP_HOSTNAME/$RTMP_HOSTNAME.crt | tee ./conf/ssl/fullchain.pem
cat ./caddy_data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/$RTMP_HOSTNAME/$RTMP_HOSTNAME.key | tee ./conf/ssl/privkey.pem

# ok