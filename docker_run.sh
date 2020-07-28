#!/bin/bash
# Sample run script.  Primarly used in build / testing

docker rm empyrion
docker run -it -p 30000-30004:30000-30004/udp -p 30000-30004:30000-30004 -v /app/docker/temp-vol:/empyrion \
-e INSTANCE_NAME="t3stn3t" \
--name empyrion \
antimodes201/empyrion-server:dev
