FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
ENV DATA_DIR /data/db
RUN apt-get update

## Set Timezone to UTC
RUN echo "UTC" > /etc/timezone;\
    dpkg-reconfigure -f noninteractive tzdata

## Set LOCALE to en_US.UTF8
RUN apt-get install -y locales;\
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen;\
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale;\
    dpkg-reconfigure --frontend=noninteractive locales;\
    update-locale LANG=en_US.UTF-8

## linux utils install
RUN apt-get install -y zip unzip aptitude nano mc curl net-tools wget software-properties-common

## Install mongodb
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6;\
    echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list;\
    apt-get update;\
    aptitude install -y mongodb-org;\
    mkdir -p ${DATA_DIR}

## Set up mongodb users
RUN MONGOD_PID=`mongod --dbpath ${DATA_DIR} --auth --fork --logpath /dev/null | head -n2 | tail -n1 | awk '{print $3}'`; \
    echo "Wait starting mongodb...";\
    sleep 7;\
    mongo --eval 'db.getSiblingDB("admin").createUser({ user: "admin", pwd: "admin", roles: ["root"] });' admin;\
    mongo -u admin -p admin --eval 'db.getSiblingDB("db1").createUser({ user: "mongouser", pwd: "1234", roles: ["dbOwner"] })' admin;\
    mongo -u admin -p admin --eval 'db.getSiblingDB("db2").createUser({ user: "mongouser", pwd: "1234", roles: ["dbOwner"] })' admin;\
    kill ${MONGOD_PID};\
    sleep 10

CMD mongod --dbpath ${DATA_DIR} --auth
