FROM alpine:3.7
LABEL maintainer="quentin.mcgaw@gmail.com" \
      description="Update the IP address of one or more of your records of one or more GoDaddy domain(s) every 5 minutes." \
      download="3.3MB" \
      size="10MB" \
      ram="6MB" \
      cpu_usage="Very low" \
      github="https://github.com/qdm12/godaddy-ip-ddns"
RUN apk add -q --progress --update --no-cache curl bash && \
    rm -rf /var/cache/apk/*
COPY godaddyddns.sh /
ENTRYPOINT /godaddyddns.sh