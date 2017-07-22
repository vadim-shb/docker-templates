#!/usr/bin/env bash
cd "$(dirname "$0")"

sudo docker build --tag vdshb/gitlab .
sudo docker run --detach \
    --name gitlab \
    --hostname gitlab.local.com \
    --publish 443:443 --publish 80:80 \
    --publish 10022:22 \
    --env "GITLAB_SHELL_SSH_PORT=10022" \
    --restart always \
#    --volume gitlab-config:/etc/gitlab \
    --volume gitlab-logs:/var/log/gitlab \
    --volume gitlab-data:/var/opt/gitlab \
    vdshb/gitlab
