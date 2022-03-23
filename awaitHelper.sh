#!/bin/sh

responseOK="false"
while [ $responseOK != "true" ]; do
    response=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$@")
    if [ "$response" = "200" ]; then
        responseOK="true"
    fi

    sleep 1
done

echo "await-helper done"
