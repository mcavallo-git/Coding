#!/bin/bash

number_of_live_dockers=$(docker ps --quiet | awk '{print $1}' | wc -l);
count_containers=$(docker ps --all --quiet | awk '{print $1}' | wc -l);
count_prunable_images=$(docker images --all | grep -v 'IMAGE' | awk '{print $3}' | wc -l);
count_prunable_skipOS_images=$(docker images --all | grep -v 'IMAGE' | grep -v 'centos' | grep -v  'openjdk' | grep -v  'postgres' | grep -v  'sonarqube' | awk '{print $3}' | wc -l);
count_networks=$(docker network ls --format='{{.ID}}  {{.Name}}' | grep -v 'bridge' | grep -v 'host' | grep -v 'none' | awk '{print $1}' | wc -l);

# Dockers Instances - Stop all Instances currently running
printf "[ $number_of_live_dockers ] Instances Running - ";
if [ $number_of_live_dockers -gt 0 ];
then
    printf "Performing STOP on all Running Instances...\n";
    docker stop $(docker ps --quiet)
		printf "\n";
else
    printf "No Action Necessary\n";
fi

# Docker Containers - Remove all Containers stored Locally
printf "[ $count_containers ] Containers Stored Locally - ";
if [ $count_containers -gt 0 ];
then
    printf "Performing REMOVE on all Local Containers...\n";
    docker rm --force $(docker ps --all --quiet)
		printf "\n";
else
    printf "No Action Necessary\n";
fi

# Prune Images
printf "[ $count_prunable_images ] Dangling Images - ";
if [ $count_prunable_images -gt 0 ];
then
    printf "Performing PRUNE on all Dangling Images...\n";
    # docker rmi --force $(docker images --all | grep -v 'IMAGE' | grep -v 'centos' | grep -v  'openjdk' | grep -v  'postgres' | grep -v  'sonarqube' | awk '{print $3}');
    docker rmi --force $(docker images --all | grep -v 'IMAGE' | awk '{print $3}');
		printf "\n";
else
    printf "No Action Necessary\n";
fi


# Prune Networks
printf "[ ${count_networks} ] Networks Stored Locally - ";
if [ $count_networks -gt 0 ];
then
	printf "PRUNING the following Networks:\n";
	docker network ls --format='{{.ID}}  {{.Name}}' | grep -v 'bridge' | grep -v 'host' | grep -v 'none'
	# docker network disconnect -f $(docker network ls | awk '{print $1}');
	docker network rm $(docker network ls --format='{{.ID}}  {{.Name}}' | grep -v 'bridge' | grep -v 'host' | grep -v 'none' | awk '{print $1}');
	printf "\n";
else
	printf "No Action Necessary\n";
fi

# Prune Volumes
echo -e "\nDocker Volume-Pruner -   Performing PRUNE on all Dangling volumes...\n"; docker volume prune -f; echo "";

# Kill all docker directories
# /home/boneal/docker/docker_rm_dirs.sh

exit 0
