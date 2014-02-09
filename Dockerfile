# VERSION 0.1
# DOCKER-VERSION  0.8.0
# AUTHOR:         Dr Nic Williams <drnicwilliams@gmail.com>
# DESCRIPTION:    Image with gnatsd project and dependecies
# TO_BUILD:       docker build -t gnatsd .
# TO_RUN:         docker run -d -p 4222:4222 -p 4244:4244 -p 8222:8222 gnatsd

FROM miksago/ubuntu-go

ADD gnatsd /gnatsd

ENV dev_version 1
RUN mkdir -p /tmp/src/github.com/apcera
ADD gnatsd /tmp/src/github.com/apcera/gnatsd

RUN export GOPATH=/tmp                  ;\
    go install github.com/apcera/gnatsd ;\
    mv /tmp/bin/gnatsd /usr/bin/

RUN gnatsd --version

ENV config_version 3
RUN mkdir -p /etc/gnatsd
ADD gnatsd.conf /etc/gnatsd/gnatsd.conf

EXPOSE 4222
EXPOSE 4244
EXPOSE 8222

CMD ["gnatsd", "-c", "/etc/gnatsd/gnatsd.conf"]
