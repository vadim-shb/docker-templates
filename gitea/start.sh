#!/usr/bin/env bash
cd "$(dirname "$0")"

sudo docker network create gitea-net #add postgresql to the same network
sudo docker run -d --name=gitea-server \
    -p 10022:22 -p 10080:3000 \
    -v gitea-server-data:/data \
    --net gitea-net \
    gitea/gitea:latest
