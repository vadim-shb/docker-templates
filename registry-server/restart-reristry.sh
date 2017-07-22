#!/usr/bin/env bash

# Registry docker image is set up to renew LetsEncript ssl-certificate on start.
#
# This command must be set in cron to periodically run this process.
#
# You can put it like this (Every sunday on 4 a.m) to /etc/crontab:
#
# 0 4     * * 1   root    docker restart registry

sudo docker restart registry
