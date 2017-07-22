#!/usr/bin/env bash

sudo docker build -t vdshb/registry .
sudo docker run -d --net=host --restart=always --name registry
        -v registry:/var/lib/registry
        -v registry-certbot:/opt/certbot
        vdshb/registry
