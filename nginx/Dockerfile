FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

## Set Timezone to Moscow-time
RUN echo "Europe/Moscow" > /etc/timezone;\
    dpkg-reconfigure -f noninteractive tzdata

## Set LOCALE to en_US.UTF8
RUN apt-get install -y locales;\
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen;\
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale;\
    dpkg-reconfigure --frontend=noninteractive locales;\
    update-locale LANG=en_US.UTF-8

# Add jessie-backports
RUN echo '\n#backports\n' | tee -a /etc/apt/sources.list;\
    echo "deb http://http.debian.net/debian jessie-backports main" | tee -a /etc/apt/sources.list;\
    apt-get update

# linux utils install
RUN apt-get install -y zip unzip aptitude nano mc curl net-tools wget software-properties-common

## Install nginx
RUN apt-get -y install nginx-full

## Configure nginx
RUN rm -rf /etc/nginx/sites-enabled/default
COPY ./nginx.conf /etc/nginx/

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
CMD nginx