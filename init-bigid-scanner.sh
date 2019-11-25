#!/usr/bin/env bash
echo "Initializing BigID scanner volume"
set -e
docker volume create --name bigid-scanner-data
docker run -d -v bigid-scanner-data:/etc/scanner --name bigid-scanner bigid/bigid-scanner:staging
#docker run -d -v bigid-scanner-data:/etc/scanner --name bigid-scanner bigid/bigid-scanner:release
sleep 10
docker cp ./kerberos/krb5.conf bigid-scanner:/etc/scanner/krb5.conf
docker cp ./kerberos/hdfs.keytab bigid-scanner:/etc/scanner/hdfs.keytab
docker exec -i bigid-scanner sudo chown -R bigid:bigid /etc/scanner
docker stop bigid-scanner
docker rm bigid-scanner
