#!/usr/bin/env bash

docker run -it --rm -v "$PWD/artifacts/":/opt/kafka-manager --entrypoint=/opt/kafka-manager/build.sh java:openjdk-8-jdk-alpine