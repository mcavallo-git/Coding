#!/bin/bash

docker run --tty --detach -p 127.0.0.1:20500:3000 --rm --name "api.boneal.net" ubuntu > /dev/null

# docker run --tty --detach -p 127.0.0.1:20500:8080 --rm --name "api.boneal.net" ubuntu > /dev/null

# docker exec -i -t $docker_name /bin/bash
