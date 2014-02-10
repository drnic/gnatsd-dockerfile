# Dockerfile for gnatsd

[gnatsd](https://github.com/apcera/gnatsd) is a high performance NATS server. This project contains a Dockerfile and an example configuration file to run gnatsd in a docker container.

## Usage

```
$ REGISTRY_ID=$(docker run -d -p 4222:4222 -p 8222:8222 -v $(pwd):/config -v $(pwd)/log:/log drnic/gnatsd)
```

See [Build from Dockerfile](#build-from-dockerfile) for instructions on modifying and building the Docker image again from the Dockerfile.


You can now test its internal state:

```
$ curl http://localhost:8222/varz
{
  "start": "2014-02-10T08:07:38.263753468Z",
  "options": {
    "max_connections": 65536,
    "user": "nats",
    "ping_interval": 120000000000,
    "ping_max": 2,
    "http_port": 8222,
    "ssl_timeout": 0.5,
    "max_control_line": 1024,
    "max_payload": 1048576
  },
  "mem": 3903488,
  "cores": 1,
  "cpu": 0,
  "connections": 0,
  "in_msgs": 0,
  "out_msgs": 0,
  "in_bytes": 0,
  "out_bytes": 0,
  "uptime": "1m12.219043078s"
}
$ curl http://localhost:8222/connz
{
  "num_connections": 0,
  "connections": []
}
```

You can play with NATS using the CLI commands installed via RubyGems (known to work on Ruby 1.9.3):

```
$ gem install nats
$ nats-sub '>' -s nats://nats:T0pS3cr3t@localhost:4222
Listening on [>]
```

Then in another terminal:

```
$ nats-pub 'some.channel' 'hello world' -s nats://nats:T0pS3cr3t@localhost:4222
Published [test.this] : 'hello world'
```

And in the `nats-sub` terminal it will show:

```
[#1] Received on [test.this] : 'hello world'
```

The `/connz` health endpoint will show the running `nats-sub` connection:

```
$ curl http://localhost:8222/connz
{
  "num_connections": 1,
  "connections": [...]
}
```

## Build from Dockerfile

```
$ git submodule update --init
$ docker build -t gnatsd .
$ REGISTRY_ID=$(docker run -d -p 4222:4222 -p 8222:8222 -v $(pwd):/config -v $(pwd)/log:/log gnatsd)
```
