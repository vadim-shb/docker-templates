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

# java install
RUN aptitude -y -t jessie-backports install openjdk-8-jdk;\
    lastJavaHome=$(find /usr/lib/jvm -maxdepth 1 -type d -name '*openjdk*' | head -n 1);\
    echo "export JAVA_HOME=$lastJavaHome" | tee -a /etc/profile.d/environment.sh;\
    echo 'PATH=$PATH:$JAVA_HOME/bin' | tee -a /etc/profile.d/environment.sh

# git install
RUN aptitude install -y git

# docker install
RUN aptitude install -y sudo;\
    aptitude install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common;\
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -;\
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable";\
    aptitude update;\
    aptitude install -y docker-ce

# gradle install
COPY gradle-1.12-all.zip /tmp/
RUN unzip /tmp/gradle-1.12-all.zip -d /opt;\
    ln -s /opt/gradle-1.12/bin/gradle /usr/bin/gradle

# ansible install
RUN apt-get -t jessie-backports install -y ansible

# install jenkins
ENV JENKINS_HOME "/var/jenkins_home"
COPY jenkins.war /opt
RUN mkdir -p $JENKINS_HOME

CMD java -jar /opt/jenkins.war
