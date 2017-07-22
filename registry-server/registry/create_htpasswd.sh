#!/usr/bin/env bash

sudo docker run --rm --entrypoint htpasswd registry:2 -Bbn <username> <password> > htpasswd