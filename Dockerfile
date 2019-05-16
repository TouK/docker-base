FROM ubuntu:bionic

LABEL maintainer="TouK"

USER root

# Set environments
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV NOTVISIBLE "in users profile"

# Install base tools
RUN apt-get update && \
    apt-get install -y apt-utils \
    net-tools netcat dnsutils telnet \
    wget curl unzip \
    openjdk-8-jre-headless \
    docker.io openssh-server

# Install wait-for-it
RUN wget -q https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN mv ./wait-for-it.sh /usr/bin/wait-for-it && chmod a+x /usr/bin/wait-for-it

# Configiure sshd
RUN mkdir /var/run/sshd
RUN echo 'root:touk' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
