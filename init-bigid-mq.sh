#!/usr/bin/env bash
echo "Initializing BigID rabbitmq volume"
set -e
docker volume create --name bigid-mq-data
docker run -d -v bigid-mq-data:/etc/rabbitmq --name bigid-mq rabbitmq:3.6.16-management
sleep 5
docker cp ./rabbitmq/. bigid-mq:/etc/rabbitmq
docker stop bigid-mq
docker rm bigid-mq