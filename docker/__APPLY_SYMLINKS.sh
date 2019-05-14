#!/bin/bash

# ===------------------------------------------------ DOCKER SHORTCUT-CREATOR ------------------------------------------------=== #
echo -e "\n$(date +'%r, %B %d, %Y (%A)')\nCreating Shortcuts to Docker-Scripts...";

SERVER_NAME=$(hostname);
DOCKER_SCRIPTS="/home/boneal/DockerScripts";

# Show all running-dockers
printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/docker_ps.sh" /docker_ps;
# Stop all running-dockers
printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/stopall.sh" /stopall_dockers;
# Snipe a specific subset of dockers
printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/docker_snipe.sh" /snipe_docker;
# Kill all running-dockers
printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/kill_all_dockers.sh" /kill_all_dockers;
# Get runtime statistics for all running-dockers
printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/docker_stats_formatted.sh" /dstats;


if [[ "${SERVER_NAME}" == *"aws-1"* ]]; then 
	# aws-1 - RFQ Server (Production - RFQ stands for "Request for Quote", as quotes only occur from live data)
	echo "Creating \"${SERVER_NAME}\"-specific shortcuts...";
	### bash_X.sh - see below
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_rfq;
	### tail_X.sh - see below
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/tail_X.sh" /tail_rfq;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/clear_rfq_log.sh" /clear_rfq_log;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/stop_rfq.sh" /stop_rfq;
	
	
elif [[ "${SERVER_NAME}" == *"aws-2"* ]]; then 
	# aws-2 - DEV Server (Development)
	echo "Creating \"${SERVER_NAME}\"-specific shortcuts...";
		### Bash into a [SPECIFIED] docker-container --> where [SPECIFIED] is parsed out of the name of the symbolic-link ($0 once-called)
		###    Example: "/bash_mdev" will have "mdev" parsed out of it, and will then attempt to bash into the [mdev.boneal.net] docker-container
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_dev;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_mdev;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_rdev;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_phpmyadmin_bnet;
		### Tail a [SPECIFIED] error-log --> where [SPECIFIED] is parsed out of the name of the symbolic-link ($0 once-called)
		###    Example: "/tail_mdev" will have "mdev" parsed out of it, and will then attempt to show the error_log for [mdev.boneal.net]
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/tail_X.sh" /tail_dev;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/tail_X.sh" /tail_mdev;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/tail_X.sh" /tail_rdev;

		### Clear a given server's logs, then tail them (resets the logs, essentially)
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/clear_mdev_log.sh" /clear_mdev_log;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/clear_dev_log.sh" /clear_dev_log;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/clear_dev_log.sh" /clear_pdev_log;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/clear_rdev_log.sh" /clear_rdev_log;
		### Stop a given docker-instance
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/stop_mdev.sh" /stop_dev;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/stop_dev.sh" /stop_mdev;
	
	
elif [[ "${SERVER_NAME}" == *"aws-3"* ]]; then 
	# aws-3 - Jenkins CI/CD Server (Continuous-Integration / Continuous-Deployment)
	echo "aws-3 - No Extra Scripts to Add";
	
	
elif [[ "${SERVER_NAME}" == *"aws-4"* ]]; then 
	# aws-4 - QA Server (Quality Assurance)
	echo "Creating \"${SERVER_NAME}\"-specific shortcuts...";
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_graylog;
	
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_sonarqube;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_sonarscanner;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_postgres;
	
	
elif [[ "${SERVER_NAME}" == *"aws-5"* ]]; then 
	# aws-5 - Middleman Server (Backups & Storage)
	echo "aws-5 - No Extra Scripts to Add";
	
	
elif [[ "${SERVER_NAME}" == *"aws-5"* ]]; then 
	# aws-6 - WordPress Server
	echo "aws-6 - No Extra Scripts to Add";
	
	
elif [[ "${SERVER_NAME}" == *"aws-7"* ]]; then 
	# aws-7 - Supplier-Gateway Server
	echo "Creating \"${SERVER_NAME}\"-specific shortcuts...";
	printf "  " && \
	ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_phpmyadmin_sg;
	
elif [[ "${SERVER_NAME}" == *"bnet-uat"* ]]; then 
	# aws-7 - Supplier-Gateway Server
	echo "Creating \"${SERVER_NAME}\"-specific shortcuts...";
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_dev.bonedge;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_prod.bonedge;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_qa.bonedge;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/bash_X.sh" /bash_uat.bonedge;

	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/tail_X.sh" /tail_dev.bonedge;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/tail_X.sh" /tail_prod.bonedge;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/tail_X.sh" /tail_qa.bonedge;
	printf "  " && ln --verbose --symbolic --force "${DOCKER_SCRIPTS}/tail_X.sh" /tail_uat.bonedge;
	
fi;

echo -e "✓ Shortcuts to Docker-Scripts Added\n";

REMOVE_LINK="/brfq"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/rfq"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/tail_rfq_access"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/tail_rfq_mail"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;

REMOVE_LINK="/bdev"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/bmdev"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/brdev"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/pdev"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/mdev"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/rdev"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;

REMOVE_LINK="/tail_dev_access"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/tail_dev_mail"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/tail_mdev_access"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/tail_mdev_mail"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/tail_rdev_access"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/tail_rdev_mail"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;

REMOVE_LINK="/tdev"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/tmdev"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/trfq"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;

REMOVE_LINK="/bash_linkos"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/blinkos"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/bash_websockets"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;
REMOVE_LINK="/bwebsockets"; if [ -L "${REMOVE_LINK}" ]; then unlink "${REMOVE_LINK}"; fi;


# ===-------------------------------------------------------------------------------------------------------------------------=== #

# Exit Shell-Script Gracefully
	exit 0;
		