#!/bin/bash
#    Docker Image-Pruner   -   by Cavalol
# 				Prunes all Unused Docker-Images

printf "\nDocker Image-Pruner\n"

number_of_docker_images_to_prune=$(docker images --filter "dangling=true" --quiet | wc -l);
pdev_running=$(docker ps | grep 'mdev_bonealnet' | awk '{print $1}' | wc -l);
mdev_running=$(docker ps | grep 'pdev_bonealnet' | awk '{print $1}' | wc -l);
rfq_running=$(docker ps | grep 'rfq_bonealnet' | awk '{print $1}' | wc -l);

# Docker Images - Prune (Remove) all Unused Images
printf "[ ${number_of_docker_images_to_prune} ] Dangling Images - ";
if [ $number_of_docker_images_to_prune -gt 0 ];
then
	if [ $pdev_running == 1 ] && [ $mdev_running == 1 ];
	then
		printf "DEV & MDEV Servers are both now running. Attempting to prune images...\n";
		# docker rmi --force $(docker images --filter "dangling=true" --quiet);
		docker rmi --force $(docker images --all | grep -v 'centos' | grep -v  'openjdk' | grep -v  'postgres' | grep -v  'sonarqube' | awk '{print $3}');
	elif [ $rfq_running == 1 ];
	then
		printf "RFQ Server - ${pdev_running} Required docker(s) found running - Performing PRUNE on all Dangling Images...\n";
		# docker rmi --force $(docker images --filter "dangling=true" --quiet);
		docker rmi --force $(docker images --all | grep -v 'centos' | grep -v  'openjdk' | grep -v  'postgres' | grep -v  'sonarqube' | awk '{print $3}');
	else
		printf "All required dockers are not yet running - Prune postponed\n";
	fi
else
	printf "No Action Necessary\n";
fi
printf "\n"

exit 0
