#!/bin/bash -x

docker stop kobuta-dev redis postgresql nginx
docker rm kobuta-dev redis postgresql nginx
docker network rm dev-net
