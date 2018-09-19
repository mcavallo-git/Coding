#!/bin/bash

# Locate a Logfile
if [ -n "${1}" ]; then
	DOCKER_TARGET="$(docker ps | grep ${1} | awk '{print $1}')";
	if [ -n "${DOCKER_TARGET}" ]; then
		DOCKER_LOGFILE="$(docker inspect --format='{{.LogPath}}' ${DOCKER_TARGET})";
		if [ -n "${DOCKER_LOGFILE}" ]; then
			echo -e "found [docker logs] for \"${1}\" (container-id \"${DOCKER_TARGET}\"): \n\n${DOCKER_LOGFILE}\n";
			sudo ls -hal ${DOCKER_LOGFILE};
		else
			echo -e "file not found: [docker logs] for \"${1}\" (container-id \"${DOCKER_TARGET}\"): \n\n${DOCKER_LOGFILE}\n";
		fi;
	else
			echo -e "no containers found which match \"${1}\"\n";
	fi;
else
	echo "Please enter a container name";
fi;
