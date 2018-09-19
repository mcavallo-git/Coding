#!/bin/bash

if [ "$#" -ne 1 ]; then
	# Program was called with anything other than a single parameter
	printf "\n   ERROR - 'Stop Snipe' Requires [1] Parameter, Received [${#}] Parameters\n";
else 

	# Correct # of parameters (just $1) - holds the name of dockers to stop
	bash_arg1=$1;

	# Stop Dockers named like the (first) inline-argument passed at time of shell-script call
	docker_ps_count=$(docker ps | grep ${bash_arg1} | awk '{print $1}' | wc -l);
	printf "[ ${docker_ps_count} ] Instances Similar to '${bash_arg1}' Running Locally - ";
	if [ $docker_ps_count -gt 0 ]; then
		printf "STOPPING the following Instances:\n";
		docker ps | grep ${bash_arg1}
		sudo docker stop $(docker ps | grep ${bash_arg1} | awk '{print $1}')
	else
		printf "No Action Necessary\n";
	fi
	
fi
