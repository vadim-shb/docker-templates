#!/usr/bin/env bash
cd "$(dirname "$0")"

sudo groupadd -g 5001 docker-postgres
sudo useradd -u 5001 -g docker-postgres docker-postgres

sudo docker build -t vdshb/postgresql .
sudo docker run --name postgresql -t -d --net=host\
                -v postgresql-logs:/var/log/postgresql\
                -v postgresql-lib:/var/lib/postgresql\
                vdshb/postgresql