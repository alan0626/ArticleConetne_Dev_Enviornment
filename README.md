## How to build your development environment

### Prerequisite

* Please install new Ubuntu server. (16.04 or 18.04 will be encouraged)
* Setup your Github key to clone the project atom-kobuta and this repository.
* Login server and continue the following steps.

### Installation

Get this repository
```sh
$ git clone <GitHub_Source_Code>
$ cd atom-kobuta-dev
```

The script will install necessary packages and docker. After installation, please logout the system and reconnect to server again.
```sh
$ sudo ./pre-install.sh
$ logout
```

Start to build up development environment
```sh
$ ./build-dev-env.sh
```

After compete the image build, you can easy start the docker development.
```sh
$ ./start-docker.sh
```

This may take few minutes to complete then you can see the docker containers running in the background.

```sh
$ docker ps -a
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                           NAMES
4dbbd78e5965        nginx:1.10.3-alpine   "nginx -g 'daemon of…"   31 minutes ago      Up 31 minutes       443/tcp, 0.0.0.0:8080->80/tcp   nginx
2b95ab84045b        atom-kobuta-dev       "/docker-entrypoint.…"   31 minutes ago      Up 31 minutes       8700/tcp                        kobuta-dev
48e7f8408883        redis:4.0             "docker-entrypoint.s…"   31 minutes ago      Up 31 minutes       6379/tcp                        redis
06fa264d23b3        postgres:9.5          "docker-entrypoint.s…"   32 minutes ago      Up 31 minutes       0.0.0.0:5432->5432/tcp          postgresql
```

The source folder under atom-kobuta-dev/atom-kobuta/atomkobuta will be mounted as a docker volume on /opt/atom/atom/atomkobuta. Which means you can directly change your code outside the docker and running your code inside the docker environment. Thus, you don't need to install development tools into containers. You can also commit your code directly. If you want to cleanup and re-start all docker containers, please execute with:
```sh
$ ./cleanup-docker.sh
$ ./start-docker.sh
```
Then you will get clean development docker containers again.

### Usage

You can access data directly via psql to 127.0.0.1:5432 and default password is "atom".
```sh
$ psql -U atom -h localhost -d atom_kobuta
```

Entering kobuta container via the command:
```sh
$ docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -it kobuta-dev /bin/bash
```

You may also access the kobuta API directly to 127.0.0.1:8080
```sh
$ curl -X GET http://127.0.0.1:8080/v0/svs/patterns/version
{"data":{"version":""},"message":"OK"}
```
