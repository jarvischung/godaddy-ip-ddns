FROM alpine:3.7
LABEL maintainer="quentin.mcgaw@gmail.com" \
      description="Update the IP address of one or more of your records of one or more GoDaddy domain(s) every 5 minutes." \
      size="10MB" \
      ram="6MB" \
      github="https://github.com/qdm12/godaddy-ip-ddns"
MAINTAINER quentin.mcgaw@gmail.com
RUN apk add --no-cache curl bash
WORKDIR /usr/script
COPY godaddyddns.sh ./
RUN chmod +x godaddyddns.sh
ENTRYPOINT ./godaddyddns.sh