#!/bin/bash -x

# MAC OS need to install this command to use realpath: brew install coreutils
curDir=$(dirname "$(realpath $0)")

# Create self docker network
docker network create dev-net

# Create postgresql container and restore sample data
docker run --net=dev-net --name postgresql -e POSTGRES_PASSWORD=atom -d -p 5432:5432 postgres:9.5
sleep 10

# MAC OS need to download postgresql APP from postgres offical website.
PGPASSWORD=atom /Applications/Postgres.app/Contents/Versions/10/bin/psql -U postgres -h localhost < atom-kobuta/data/postgresql/init.sql

# Create redis server
docker run --net=dev-net --name redis -d redis:4.0

# Start the dev container, and mapping source code folder from hosted server.
docker run --net=dev-net --name kobuta-dev -d -v $curDir/atom-kobuta/atomkobuta:/opt/atom/atomkobuta atom-kobuta-dev
docker exec -it kobuta-dev python3 /opt/atom/initdb.py

# Start nginx and forword request to atom-kobuta uwsgi:8700
docker run --net=dev-net --name nginx -d -p 8080:80 nginx:1.10.3-alpine
docker cp atom-kobuta/data/nginx/nginx.conf nginx:/etc/nginx
docker cp atom-kobuta/data/nginx/conf.d/atom-kobuta.conf nginx:/etc/nginx/conf.d/default.conf
docker restart nginx

