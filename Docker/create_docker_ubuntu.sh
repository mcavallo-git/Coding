#!/bin/bash
rand_port=$(shuf -i 40000-42500 -n 1);
docker_name="docker_port_${rand_port}"
docker run --tty --detach --rm --name "${docker_name}" ubuntu > /dev/null
printf "    ===--  Started Docker:  ${docker_name}...\n"
printf "    ===--    Bashing Into:  ${docker_name}...\n"
docker exec -i -t ${docker_name} /bin/bash;
# docker exec -i -t ${docker_name} -p 127.0.0.1:80:8080 /bin/bash;
