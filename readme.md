# Kafka Manager (Alpine Docker Image)

Get the image

```bash
docker pull frankdejonge/kafka-manager-alpine
```

docker-compose.yml example:

```yaml
version: "3"
services:
    kafka-manager:
        image: frankdejonge/kafka-manager-alpine
        container_name: kafka-manager
        environment:
          - ZK_HOSTS
          - APPLICATION_SECRET
          - KAFKA_MANAGER_AUTH_ENABLED
          - KAFKA_MANAGER_USERNAME
          - KAFKA_MANAGER_PASSWORD
        ports:
          - 9000:9000
```

docker run example:

```bash
docker run -it --rm -e ZK_HOSTS=12.123.12.123:2181,23.234.23.234:2181 -e APPLICATION_SECRET=haha123410101010101010 -p 9000:9000 frankdejonge/kafka-manager-alpine
```