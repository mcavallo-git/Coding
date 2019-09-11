#!/bin/bash

# Spin-up the jenkins docker
docker run \
-u root \
--rm \
-d \
-p 8080:8080 \
-p 50000:50000 \
-v "jenkins-data:/var/jenkins_home" \
-v "/var/run/docker.sock:/var/run/docker.sock" \
"jenkinsci/blueocean" \
;

# ------------------------------------------------------------

# Bash into docker-instance
JENKINS_DOCKER_NAME=$(docker container ls --format '{{.Names}}') && \
E1="LINES=$(tput lines)" && \
E2="COLUMNS=$(tput cols)" && \
docker exec \
-e "${E1}" \
-e "${E2}" \
-it \
"${JENKINS_DOCKER_NAME}" \
"/bin/bash" \
;

# ------------------------------------------------------------
#	
#	Citation(s)
#
#		jenkins.io  |  "Installing Jenkins"  |  https://jenkins.io/doc/book/installing/
#
#		hub.docker.com  |  "jenkinsci/blueocean"  |  https://hub.docker.com/r/jenkinsci/blueocean/
#
# ------------------------------------------------------------