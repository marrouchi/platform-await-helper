# platform-await-helper

The platform-await-helper makes a service call to a specified URL, and exits upon receiving a HTTP status 200.

## Usage

A docker-compose file calling the platform-await-helper should look as follows:

```yml
services:
  await-helper:
    image: jembi/await-helper:1.0
    deploy:
      replicas: 1
      restart_policy:
        condition: none
    command: '<flags> <URL>'
```

- Make sure to include the `restart_policy` field, or docker will attemp to restart the service, even if it exited as expected.

- The `command` field appends any curl flags and the service URL to a curl command, hence, flags must adhere to those set out by curl.
