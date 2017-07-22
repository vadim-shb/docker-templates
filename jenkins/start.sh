#!/usr/bin/env bash

sudo docker build -t vdshb/jenkins .
sudo docker run --name jenkins -t -d --net=host \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -v jenkins_home:/var/jenkins_home \
            vdshb/jenkins
