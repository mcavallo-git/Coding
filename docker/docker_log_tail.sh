#!/bin/bash

# Tail a Docker's Logfile
if [ -n "${1}" ]; then
	DOCKER_TARGET="$(docker ps | grep ${1} | awk '{print $1}')";
	if [ -n "${DOCKER_TARGET}" ]; then
		if [ "$(echo ${DOCKER_TARGET} | wc -l)" == "1" ]; then
			DOCKER_LOGFILE="$(docker inspect --format='{{.LogPath}}' ${DOCKER_TARGET})";
			if [ -n "${DOCKER_LOGFILE}" ]; then
				echo -e "found [docker logs] for \"${1}\" (container-id \"${DOCKER_TARGET}\"): \n\n${DOCKER_LOGFILE}\n";
				docker logs -f "${DOCKER_TARGET}";
			else
				echo -e "file not found: [docker logs] for \"${1}\" (container-id \"${DOCKER_TARGET}\"): \n\n${DOCKER_LOGFILE}\n";
			fi;
		else
			echo -e "found more than 1 docker, please narrow search criteria";
		fi;
	else
			echo -e "no containers found which match \"${1}\"\n";
	fi;
else
	echo "please pass [a container name] or [a unique substring to target a container name]";
fi;
