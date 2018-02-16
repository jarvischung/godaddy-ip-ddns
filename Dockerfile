FROM alpine:latest
MAINTAINER quentin.mcgaw@gmail.com
RUN apk add --no-cache curl bash
WORKDIR /usr/script
COPY godaddyddns.sh ./
RUN chmod +x godaddyddns.sh
ENTRYPOINT ./godaddyddns.sh