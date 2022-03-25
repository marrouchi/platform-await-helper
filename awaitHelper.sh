#!/bin/sh

ResponseOK="false"
StartTime=$(date +%s)
Warned="false"
while [ $ResponseOK != "true" ]; do
    sleep 1

    currentTime=$(date +%s)
    if [ "$(($currentTime - $StartTime))" -ge 60 ] && [ $Warned = "false" ]; then
        echo "Warning: Waited 60s with no response. This is taking longer than it should..."
        Warned="true"
    elif [ "$(($currentTime - $StartTime))" -ge 130 ] && [ $Warned = "true" ]; then
        echo "Fatal: Waited 130s with no response. Exiting..."
        exit 1
    fi

    response=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$@")
    if [ "$response" = "200" ]; then
        ResponseOK="true"
    fi
done

echo "await-helper done"
