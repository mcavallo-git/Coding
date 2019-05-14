#!/bin/bash

	#    Docker Snipe   -   by Cavalol
	#				Requires a single argument be passed via command line, ex)   ./docker_sweep.sh boneal_rfq
	# 				1.  Stops Instances similar to '$1'
	# 				2.  Removes Containers similar to '$1'
	# 				3.  Removes Images similar to '$1'
	# 				4.  Removes Networks
	# 				5.  Performs [docker system prune]

# Header
THIS_SCRIPT=$(basename "${0}")
echo -e "\n$(date +'%r, %B %d, %Y (%A)')\nStarting ${THIS_SCRIPT} as user (whoami) [$(whoami)]"

if [ "$#" -ne 1 ]; then
	# Program was called with anything other than a single parameter
	printf "\n   ERROR - '${THIS_SCRIPT}' Requires [1] Parameter (Docker-Substring-Target), Received [${#}] Parameters\n";
else 

	# Correct # of parameters (just $1) - holds the name of dockers to stop
	bash_arg1=$1;
	printf "\nDocker Snipe - \"${bash_arg1}\"\n"
	
	docker_ps_count=$(docker ps | grep ${bash_arg1} | awk '{print $1}' | wc -l);
	docker_ps_all_count=$(docker ps --all | grep ${bash_arg1} | awk '{print $1}' | wc -l);
	docker_networks_all_count=$(docker network ls --format='{{.ID}}  {{.Name}}' | grep ${bash_arg1} | awk '{print $1}' | wc -l);
	docker_images_all_count=$(docker images --all | grep ${bash_arg1} | awk '{print $3}' | wc -l);
	docker_images_skipOS_count=$(docker images --all | grep ${bash_arg1} | grep -v 'centos' | grep -v 'node' | awk '{print $3}' | wc -l);
	
	HEAD_TEXT="matching \"${bash_arg1}\" stored locally - ";
	
	# Dockers Instances - Stop all running-Instances whichmatch the given Search-String
	printf "[ ${docker_ps_count} ] Instances ${HEAD_TEXT}";
	if [ $docker_ps_count -gt 0 ]; then
		printf "STOPPING via \"docker stop ...\":\n";
		docker ps | grep ${bash_arg1};
		docker stop $(docker ps | grep ${bash_arg1} | awk '{print $1}')
		printf "\n";
	else
		printf "No Action Necessary\n";
	fi;
	
	# Docker Containers - Remove all Containers which match the given Search-String
	printf "[ ${docker_ps_all_count} ] Containers ${HEAD_TEXT}";
	if [ $docker_ps_all_count -gt 0 ]; then
		printf "FORCE-REMOVING via \"docker rm --force ...\":\n";
		docker ps --all | grep ${bash_arg1};
		docker rm --force $(docker ps --all | grep ${bash_arg1} | awk '{print $1}');
		printf "\n";
	else
		printf "No Action Necessary\n";
	fi;
	
	# Kill Images
	printf "[ ${docker_images_all_count} ] Images ${HEAD_TEXT}";
	if [ $docker_images_all_count -gt 0 ]; then
		printf "FORCE-REMOVING via \"docker rmi --force ...\":\n";
		docker images --all | grep ${bash_arg1};
		# docker rmi --force $(docker images --all | grep ${bash_arg1} | grep -v 'centos' | grep -v 'node' | awk '{print $3}');
		docker rmi --force $(docker images --all | grep ${bash_arg1} | awk '{print $3}');
		printf "\n";
	else
		printf "No Action Necessary\n";
	fi;
	
	# Kill Networks
	printf "[ ${docker_networks_all_count} ] Networks ${HEAD_TEXT}";
	if [ $docker_networks_all_count -gt 0 ]; then
		printf "FORCE-REMOVING via \"docker network rm ...\":\n";
		docker network ls --format='{{.ID}}  {{.Name}}' | grep -v 'bridge' | grep -v 'host' | grep -v 'none' | grep ${bash_arg1};
		docker network rm $(docker network ls --format='{{.ID}}  {{.Name}}' | grep -v 'bridge' | grep -v 'host' | grep -v 'none' | grep ${bash_arg1} | awk '{print $1}');
		printf "\n";
	else
		printf "No Action Necessary\n";
	fi;
	
	# Prune System
	printf "[ - ] Clean-Up & Exit - ";
	printf "Running generic sweep \"docker system prune --filter 'label=\"${bash_arg1}\"' --force\":\n";
	docker system prune --force --filter 'label="'${bash_arg1}'"' --force;
	echo "";
	
fi;
	
# Footer
echo -e "\n$(date +'%r, %B %d, %Y (%A)')\n✓ Finished ${THIS_SCRIPT}";
exit 0;