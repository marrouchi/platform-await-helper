#!/bin/sh

responseOK="false"
startTime=$(date +%s)
while [ $responseOK != "true" ]; do
    response=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$@")
    if [ "$response" = "200" ]; then
        responseOK="true"
    fi

    if [ $(expr $currentTime - $startTime) -ge "60" ]; then
        echo "Waited 60s with no response, exiting..."
        exit 1
    fi

    sleep 1
done

echo "await-helper done"
