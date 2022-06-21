#!/bin/sh

START_TIME=$(date +%s)

echo "Waiting for $@"
until [ $(curl --write-out "%{http_code}\n" --silent --output /dev/null "$@") = "200" ]; do
    TimeDiff=$(($(date +%s) - $START_TIME))
    if [ "$TimeDiff" -ge 60 ] && [ "$TimeDiff" -lt 61 ]; then
        echo "Warning: Waited 60s with no response. This is taking longer than it should..."
    elif [ "$TimeDiff" -ge 300 ]; then
        echo "Fatal: Waited 300s with no response. Exiting..."
        exit 1
    fi

    sleep 1
done

echo "Successful response from $@"
