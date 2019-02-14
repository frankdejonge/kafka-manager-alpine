FROM java:8-jre-alpine

ENV SERVICE_HOME=/opt/kafka-manager \
    SERVICE_NAME=kafka-manager \
    SERVICE_VERSION=1.3.3.22 \
    SERVICE_URL=https://github.com/yahoo/kafka-manager
ENV SERVICE_CONF=${SERVICE_HOME}/conf/application.conf \
    DOWNLOAD_URL=https://github.com/yahoo/kafka-manager/archive/${SERVICE_VERSION}.tar.gz \
    DOWNLOAD_TARGET=/opt/kafka-manager-${SERVICE_VERSION}.tar.gz

ADD ${SERVICE_NAME}-${SERVICE_VERSION}.zip /opt/

RUN unzip /opt/${SERVICE_NAME}-${SERVICE_VERSION}.zip -d /opt/ && \
    rm /opt/${SERVICE_NAME}-${SERVICE_VERSION}.zip && \
    mv /opt/${SERVICE_NAME}-${SERVICE_VERSION} ${SERVICE_HOME}

ADD application.conf ${SERVICE_HOME}/conf/application.conf

RUN set -ex && apk --no-cache add bash

EXPOSE 9000

CMD ${SERVICE_HOME}/bin/kafka-manager -Dkafka-manager.zkhosts=${ZK_HOSTS} -Dconfig.file=${SERVICE_HOME}/conf/application.conf -Dhttp.port=9000
