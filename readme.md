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