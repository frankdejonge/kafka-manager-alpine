FROM java:openjdk-8-jdk-alpine as compiler

# KEEP IN SYNC WITH BLOCK BELOW
ENV SERVICE_HOME=/opt/kafka-manager \
    SERVICE_NAME=kafka-manager \
    SERVICE_VERSION=2.0.0.2
ENV SERVICE_CONF=${SERVICE_HOME}/conf/application.conf \
    DOWNLOAD_URL=https://github.com/yahoo/kafka-manager/archive/${SERVICE_VERSION}.tar.gz \
    DOWNLOAD_TARGET=/opt/${SERVICE_NAME}-${SERVICE_VERSION}.tar.gz
# THIS IS THE END OF THE BLOCK

RUN mkdir -p /opt/kafka-manager
ADD ./compile.sh /opt/kafka-manager/
RUN /opt/kafka-manager/compile.sh

FROM java:8-jre-alpine

# THIS IS THE BLOCK BELOW
ENV SERVICE_HOME=/opt/kafka-manager \
    SERVICE_NAME=kafka-manager \
    SERVICE_VERSION=2.0.0.2
ENV SERVICE_CONF=${SERVICE_HOME}/conf/application.conf \
    DOWNLOAD_URL=https://github.com/yahoo/kafka-manager/archive/${SERVICE_VERSION}.tar.gz \
    DOWNLOAD_TARGET=/opt/${SERVICE_NAME}-${SERVICE_VERSION}.tar.gz
# THIS IS THE END OF THE BLOCK BELOW

COPY --from=compiler /opt/${SERVICE_NAME}/target/universal/${SERVICE_NAME}-${SERVICE_VERSION}.zip \
     /opt/${SERVICE_NAME}-${SERVICE_VERSION}.zip

RUN unzip /opt/${SERVICE_NAME}-${SERVICE_VERSION}.zip -d /opt/ && \
    rm /opt/${SERVICE_NAME}-${SERVICE_VERSION}.zip && \
    mv /opt/${SERVICE_NAME}-${SERVICE_VERSION} ${SERVICE_HOME}


ADD application.conf ${SERVICE_HOME}/conf/application.conf

RUN set -ex && apk --no-cache add bash

EXPOSE 9000

CMD ${SERVICE_HOME}/bin/kafka-manager -Dpidfile.path=/dev/null -Dkafka-manager.zkhosts=${ZK_HOSTS} -Dconfig.file=${SERVICE_HOME}/conf/application.conf -Dhttp.port=9000
