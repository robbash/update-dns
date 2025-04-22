#!/bin/bash

# When using a `.env` file those variables may come with line-breaks
ZONE_ID=`echo $ZONE_ID`
RECORD_ID=`echo $RECORD_ID`
RECORD_NAME=`echo $RECORD_NAME`
AUTH_TOKEN=`echo $AUTH_TOKEN`

echo ZONE_ID=$ZONE_ID
echo RECORD_ID=$RECORD_ID
echo RECORD_NAME=$RECORD_NAME
echo AUTH_TOKEN=****

if [ -z "${ZONE_ID}" ] || [ -z "${RECORD_ID}" ] || [ -z "${RECORD_NAME}" ] || [ -z "${AUTH_TOKEN}" ]; then
    echo "Expecting values for: ZONE_ID, RECORD_ID, RECORD_NAME, AUTH_TOKEN"
    exit 1
fi

ip=$(curl -s https://ipv4.icanhazip.com)

request="curl -s -X PUT \"https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID\" \
    -H \"Authorization: Bearer $AUTH_TOKEN\" \
    -H \"Content-Type: application/json\" \
    --data '{\"id\":\"$ZONE_ID\",\"type\":\"A\",\"name\":\"$RECORD_NAME\",\"content\":\"$ip\"}'"

update=$(eval $request)

if [[ $DEBUG == "true" ]]; then
    echo -e "\nDEBUG OUTPUT:\n"
    echo -e "Request:\n${request}";
    echo -e "Response:\n${update}";
fi

if [[ $update == *"\"success\":false"* ]]; then
    message="API UPDATE FAILED. DUMPING RESULTS:\n$update"
    echo -e "$message"
    exit 1
fi
