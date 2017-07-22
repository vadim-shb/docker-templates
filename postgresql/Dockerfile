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

## Install postgresql
ENV PG_VERSION=9.4
RUN groupadd -g 5001 postgres;\
    useradd -u 5001 -g postgres postgres;\
    apt-get -y install postgresql-${PG_VERSION} postgresql-contrib-${PG_VERSION} postgresql-client-${PG_VERSION}

## Configure postgresql
USER postgres
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/${PG_VERSION}/main/pg_hba.conf;\
    echo "listen_addresses='*'" >> /etc/postgresql/${PG_VERSION}/main/postgresql.conf

## Create new user and database
RUN /etc/init.d/postgresql restart;\
    psql --command "CREATE USER pguser WITH SUPERUSER PASSWORD '1234';";\
    createdb -O pguser -E UTF8 dbname

COPY postgresql.conf /etc/postgresql/${PG_VERSION}/main/

CMD /usr/lib/postgresql/${PG_VERSION}/bin/postgres -D /var/lib/postgresql/${PG_VERSION}/main -c config_file=/etc/postgresql/${PG_VERSION}/main/postgresql.conf