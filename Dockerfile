# Touk base jdk image

# Pull base image
ARG BASE_IMAGE_TAG
FROM openjdk:${BASE_IMAGE_TAG:-8u242-jdk-stretch}

LABEL maintainer="TouK"

USER root

# Set environments
ENV NOTVISIBLE "in users profile"

# Install base tools
RUN apt-get update && \
    apt-get install -y apt-utils \
    net-tools netcat dnsutils telnet \
    wget curl unzip \
    openssh-server

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
WORKDIR /root
