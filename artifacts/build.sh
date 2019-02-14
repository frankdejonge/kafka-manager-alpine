#!/usr/bin/env sh

SERVICE_HOME=/opt/kafka-manager
SERVICE_NAME=kafka-manager
SERVICE_VERSION=1.3.3.22
SERVICE_USER=kafka
SERVICE_UID=10003
SERVICE_GROUP=kafka
SERVICE_GID=10003
SERVICE_URL=https://github.com/yahoo/kafka-manager
SERVICE_CONF=${SERVICE_HOME}/conf/application.conf
DOWNLOAD_URL=https://github.com/yahoo/kafka-manager/archive/${SERVICE_VERSION}.tar.gz
DOWNLOAD_TARGET=/opt/kafka-manager-${SERVICE_VERSION}.tar.gz

set -ex \
  && apk --no-cache add \
      bash \
      tar \
      wget \
      unzip

wget ${DOWNLOAD_URL} -O ${DOWNLOAD_TARGET} && \
tar --strip-components=1 --show-stored-names -zxf ${DOWNLOAD_TARGET} -C /opt/kafka-manager && \
ls -la /opt/kafka-manager/ && \
cd /opt/kafka-manager && \
./sbt clean dist