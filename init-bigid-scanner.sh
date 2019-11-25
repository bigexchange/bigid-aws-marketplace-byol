#!/usr/bin/env bash
echo "Initializing BigID scanner volume"
set -e
docker volume create --name bigid-scanner-data
docker run -d -v bigid-scanner-data:/etc/scanner --name bigid-scanner 403495124976.dkr.ecr.us-east-1.amazonaws.com/2ba1356e-b944-40e3-a585-25623721f6fd/cg-2527148120/bigid-scanner:Placeholder1-latest
#docker run -d -v bigid-scanner-data:/etc/scanner --name bigid-scanner 742572016373.dkr.ecr.us-east-1.amazonaws.com/bigid-scanner:${BIGID_VERSION}
sleep 10
docker exec -i bigid-scanner sudo chown -R bigid:bigid /etc/scanner
docker stop bigid-scanner
docker rm bigid-scanner
