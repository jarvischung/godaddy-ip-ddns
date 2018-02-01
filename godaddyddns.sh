#!/bin/bash

if [[ -z "${NAME}" ]]; then
    NAME="@" # we assume the name is the default @
fi
if [[ -z "${DELAY}" ]]; then
    DELAY=300
fi
while true;
do
    echo "Checking for IP address change...";
    godaddyresult=$(curl -s -X GET -H "Authorization: sso-key $KEY:$SECRET" "https://api.godaddy.com/v1/domains/$DOMAIN/records/A/$NAME");
    godaddyip=$(echo $godaddyresult | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b");
    ipresult=$(curl -s GET https://diagnostic.opendns.com/myip);
    ip=$(echo $ipresult | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b");
    if [ "$ip" != "$godaddyip" ];
     then
        echo "Updating $DOMAIN to new IP address $ip ..."
        result=$(curl -i -s -X PUT -H "Authorization: sso-key $KEY:$SECRET" -H "Content-Type: application/json" -d '{"data":"'$ip'","ttl":600}' "https://api.godaddy.com/v1/domains/$DOMAIN/records/A/$NAME")
    fi
    echo "DONE. Waiting for $DELAY seconds.";
    sleep "$DELAY";
done