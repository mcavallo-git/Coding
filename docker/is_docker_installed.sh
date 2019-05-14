#!/bin/bash
docker --version | grep "Docker version" && is_docker_installed=1 || is_docker_installed=0;
if [ "${is_docker_installed}" -eq 1 ]; then
	echo "Docker IS	installed"
else
	echo "Docker is NOT installed"
fi; 