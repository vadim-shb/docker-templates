#!/usr/bin/env bash
cd "$(dirname "$0")"

PARENT_IMAGE=$(cat Dockerfile | grep FROM | head -n1 | awk '{print $2}')
BUILD_VERSION=2

sudo docker login --username user --password pass registry.example.com:5000
sudo docker pull ${PARENT_IMAGE}
sudo docker build -t registry.example.com:5000/vdshb/foo:${BUILD_VERSION} .
sudo docker push registry.example.com:5000/vdshb/foo:${BUILD_VERSION}
sudo docker logout registry.example.com:5000
