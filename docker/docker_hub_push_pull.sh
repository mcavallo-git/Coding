#!/bin/bash

#  ---------------------------------------------------------------------------------------------------------------------------------------------------- #
#
# AWS-1
# 	SUBDOMAIN="rfq"; # www.boneal.net     -   bonealnetrfq
# AWS-2
# 	SUBDOMAIN="mdev"; # mdev.boneal.net   -   bonealnetmdev
# 	SUBDOMAIN="pdev"; # dev.boneal.net    -   bonealnetdev
# 	SUBDOMAIN="rdev"; # rdev.boneal.net    -   bonealnetrdev
#
#  ---------------------------------------------------------------------------------------------------------------------------------------------------- #
#
# - EXAMPLE_CONFIG_FILE -
#
# 	CODEBASE="dev"
# 	DOCKERHUB_USER="bonealnetrdev"
# 	DOCKERHUB_REPO="rdev_bonealnet"
# 	DOCKERHUB_PASS="PASSWORD_HERE"
#
#  ---------------------------------------------------------------------------------------------------------------------------------------------------- #

#!/bin/bash

# PUSH

IMAGENAME="";
if [[ "$0" == *"rfq"* ]]; then # rfq (www)
	IMAGENAME="rfq";
elif [[ "$0" == *"mdev"* ]]; then # mdev
	IMAGENAME="mdev";
elif [[ "$0" == *"pdev"* ]]; then # pdev
	IMAGENAME="pdev";
elif [[ "$0" == *"rdev"* ]]; then # rdev
	IMAGENAME="rdev";
else # err
	echo -e "\n\n $ 0: Invalid Subdomain in $ 0: $0\n\n";
	exit 1;
fi;

DOCKER_CREDS="/var/lib/credentials/docker";
DOCKER_HUB_CREDENTIALS="${DOCKER_CREDS}/docker_hub_${IMAGENAME}.conf";

source "${DOCKER_HUB_CREDENTIALS}";

LATEST_IMAGE_REFERENCE="${DOCKER_CREDS}/latest_image_${IMAGENAME}";

if [[ "$0" == *"push"* ]]; then
	
	# PUSH
	docker login -u="${DOCKERHUB_USER}" -p="${DOCKERHUB_PASS}";
	LATEST="version_$(date +'%Y%m%d-%H%M%S')";
	echo "${LATEST}" > "${LATEST_IMAGE_REFERENCE}";
	TARGET_IMAGE="${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${LATEST}";
	docker tag "${DOCKERHUB_REPO}" "${TARGET_IMAGE}";
	docker push "${TARGET_IMAGE}";
	docker logout;
	
elif [[ "$0" == *"pull"* ]]; then

	# PULL
	docker login -u="${DOCKERHUB_USER}" -p="${DOCKERHUB_PASS}";
	LATEST="$(cat ${LATEST_IMAGE_REFERENCE})";
	DOCKER_HUB_FULL_PATH="${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${LATEST}";
	docker pull "${DOCKER_HUB_FULL_PATH}";
	docker logout;
	
else
	
	# err
	echo -e "\n\n $ 0: Invalid Push/Pull Command: $0\n\n";
	exit 1;
	
fi;


#  ---------------------------------------------------------------------------------------------------------------------------------------------------- #
