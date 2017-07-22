FROM registry:2

# Add community repos
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update; apk upgrade

# Certbot install
RUN apk add certbot --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/community --allow-untrusted

RUN mkdir -p /opt/certbot/config;\
    mkdir -p /opt/certbot/logs;\
    mkdir -p /opt/certbot/work

# Registry configuration
COPY config.yml /etc/docker/registry/config.yml
COPY htpasswd /etc/docker/registry/htpasswd


ENTRYPOINT certbot certonly --standalone --non-interactive --preferred-challenges http --email sysadmins@example.com --agree-tos -d registry.example.com --config-dir /opt/certbot/config --logs-dir /opt/certbot/logs --work-dir /opt/certbot/work &&\
           /entrypoint.sh /etc/docker/registry/config.yml
