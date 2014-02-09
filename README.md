# Dockerfile for gnatsd

[gnatsd](https://github.com/apcera/gnatsd) is a high performance NATS server. This project contains a Dockerfile and an example configuration file to run gnatsd in a docker container.

## Usage

```
$ git submodule update --init
$ docker build -t <username>/gnatsd .
$ REGISTRY_ID=$(docker run -d -p 4222:4222 -p 4244:4244 -p 8222:8222  <username>/gnatsd)
```

