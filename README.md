TouK Docker Base Image [![Build Status](https://travis-ci.org/TouK/docker-base.svg?branch=master)](https://travis-ci.org/TouK/docker-base)
===

This repository provides base docker image. It has dependencies like:

* Network tools: net-tools netcat dnsutils telnet
* Base tools: curl / wget / unzip / vim
* Java 8, docker.io
* SSH configuration (https://docs.docker.com/engine/examples/running_ssh_service/)
* wait-for-it (https://github.com/vishnubob/wait-for-it)

Installation
---

* Docker Hub: https://hub.docker.com/r/touk/base
* Image: touk/base:latest

Build from Source
---

    docker build -t touk/base