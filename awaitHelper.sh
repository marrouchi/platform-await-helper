#!/bin/sh

START_TIME=$(date +%s)

Warned="false"
echo "Waiting for $@"
until [ $(curl --write-out "%{http_code}\n" --silent --output /dev/null "$@") = "200" ]; do
    currentTime=$(date +%s)
    if [ "$(($currentTime - $START_TIME))" -ge 60 ] && [ $Warned = "false" ]; then
        echo "Warning: Waited 60s with no response. This is taking longer than it should..."
        Warned="true"
    elif [ "$(($currentTime - $START_TIME))" -ge 120 ] && [ $Warned = "true" ]; then
        echo "Fatal: Waited 130s with no response. Exiting..."
        exit 1
    fi

    sleep 1
done

echo "Successful response from $@"
