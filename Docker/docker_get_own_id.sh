#!/bin/bash

ENV_DOCKER_ID="$(head -1 /proc/self/cgroup|cut -d/ -f3)";
if [ -n "${ENV_DOCKER_ID}" ]; then
	echo "DOCKER ENVIRONMENT DETECTED (w/ Docker-ID \"${ENV_DOCKER_ID}\")";
else
	echo "NON-DOCKER ENVIONMENT DETECTED (no Docker-ID found)";
fi;
