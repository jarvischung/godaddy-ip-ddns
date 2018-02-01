FROM alpine:latest

MAINTAINER quentin.mcgaw@gmail.com

RUN apk add --no-cache bash
RUN apk add --no-cache curl

WORKDIR /usr/script

COPY godaddyddns.sh ./

ENV DOMAIN example.com
ENV NAME www
ENV KEY abcdef
ENV SECRET qwerty

RUN chmod 555 godaddyddns.sh

CMD while /bin/true; do ./godaddyddns.sh; /bin/sleep 300; done