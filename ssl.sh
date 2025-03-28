#!/usr/bin/env bash
source .env

# run caddy once and wait for certificate logs
mkdir -p ./conf/ssl/
docker rm -f rtmpcaddy
docker run -v ./caddy_data:/data --name rtmpcaddy -p 80:80 -p 443:443 caddy caddy reverse-proxy --from $NGINX_SERVERNAME --to http://localhost

# copy cert to ssl path
cat ./caddy_data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/$NGINX_SERVERNAME/$NGINX_SERVERNAME.crt | tee ./conf/ssl/fullchain.pem
cat ./caddy_data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/$NGINX_SERVERNAME/$NGINX_SERVERNAME.key | tee ./conf/ssl/privkey.pem

# ok, you're ready to 
# next:
# docker compose up --build
