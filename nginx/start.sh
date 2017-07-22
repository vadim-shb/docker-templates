#!/usr/bin/env bash
cd "$(dirname "$0")"

sudo docker build -t vdshb/nginx .
#todo: check if all the logs in /var/log/nginx
sudo docker run --name nginx -t -d --net=host \
                -v nginx-logs:/var/log/nginx \
                vdshb/nginx