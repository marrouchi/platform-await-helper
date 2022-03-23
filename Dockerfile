FROM curlimages/curl:7.82.0

ADD awaitHelper.sh .

ENTRYPOINT [ "./awaitHelper.sh" ]
