# RTMP Proxy

Docker container for running NGINX as an RTMP proxy for streaming video to multiple services. Complete with SSL and authentication.

## Setup

You will need to build your own .env file and fill out all of the values (including generating SSL certs):

```sh
NGINX_HTTP_PORT=8080
NGINX_HTTPS_PORT=8443
NGINX_SERVERNAME=[FQDN or server name]
NGINX_ROOT=/var/www/html
NGINX_RTMP_PORT=1935
RTMP1_URL=[YouTube or other stream URL]
RTMP1_KEY=[Your stream key, keep this secret!]
RTMP2_URL=[Second streaming service URL]
RTMP2_KEY=[Second streaming service key]
RTMP_APP=live
RTMP_PASS=[A string that will be the password for OBS or other software]
SSL_CERT_PATH=/etc/ssl/fullchain.pem
SSL_KEY_PATH=/etc/ssl/privkey.pem
```

Go to [./ssl.sh](ssl.sh), run caddy for your domain certificae

and then run `docker compose up --build` for serving the RTMP proxy server

## Usage of OBS

In OBS, go to settings -> stream:

Service = Custom...  
Server = rtmp://[hostname or IP]/live  
Stream Key = streamer?pwd=[Your Password]  

## Usage of DJI MIMO

Connect your camera -> LiveStreaming -> RTMP

Wifi = ... fill your wifi SSID and password  
RTMP URL = rtmps://[hostname or IP]/live

Note: while unable to use password in DJI MIMO. For better security, rename your RTMP_APP to a secret string and use RTMPS only

## References:

https://www.scaleway.com/en/docs/setup-rtmp-streaming-server/ - Huge thanks here for the authentication part.
https://smartshitter.com/musings/2018/06/nginx-rtmp-streaming-with-slightly-improved-authentication/ - Interesting take on authentication.
https://www.hostwinds.com/guide/live-streaming-from-a-vps-with-nginx-rtmp/ - A complete guide with some other options (like HLS).
