#!/bin/bash

DOCKER_CREDS="/var/lib/docker";
IMAGENAME="myapp";

DOCKER_HUB_CREDENTIALS="${DOCKER_CREDS}/docker_hub_${IMAGENAME}.conf";

source "${DOCKER_HUB_CREDENTIALS}";

LATEST_IMAGE_REFERENCE="${DOCKER_CREDS}/latest_image_${IMAGENAME}";

#  ---------------------------------------------------------------------------------------------------------------------------------------------------- #
if [[ "$0" == *"push"* ]]; then
	
	# PUSH

	docker login -u="${DOCKERHUB_USER}" -p="${DOCKERHUB_PASS}";
	LATEST="version_$(date +'%Y%m%d-%H%M%S')";
	echo "${LATEST}" > "${LATEST_IMAGE_REFERENCE}";
	TARGET_IMAGE="${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${LATEST}";
	docker tag "${DOCKERHUB_REPO}" "${TARGET_IMAGE}";
	docker push "${TARGET_IMAGE}";
	docker logout;

#  ---------------------------------------------------------------------------------------------------------------------------------------------------- #
elif [[ "$0" == *"pull"* ]]; then

	# PULL

	docker login -u="${DOCKERHUB_USER}" -p="${DOCKERHUB_PASS}";
	LATEST="$(cat ${LATEST_IMAGE_REFERENCE})";
	DOCKER_HUB_FULL_PATH="${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${LATEST}";
	docker pull "${DOCKER_HUB_FULL_PATH}";
	docker logout;

#  ---------------------------------------------------------------------------------------------------------------------------------------------------- #
else
	
	# ERROR (NEITHER PUSH NOR PULL)

	echo -e "\n\n $ 0: Invalid Push/Pull Command: $0\n\n";
	exit 1;
	
fi;

#  ---------------------------------------------------------------------------------------------------------------------------------------------------- #
