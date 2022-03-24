#!/bin/sh

responseOK="false"
startTime=$(date +%s)
while [ $responseOK != "true" ]; do
    sleep 1

    currentTime=$(date +%s)
    if [ $(expr $currentTime - $startTime) -ge 60 ] && [ $warned == "false" ]; then
        echo "Warning: Waited 60s with no response. This is taking longer than it should..."
        warned="true"
    elif [ $(expr $currentTime - $startTime) -ge 130 ] && [ $warned == "true" ]; then
        echo "Fatal: Waited 130s with no response. Exiting..."
        exit 1
    fi

    response=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$@")
    if [ "$response" = "200" ]; then
        responseOK="true"
    fi
done

echo "await-helper done"
