#!/bin/bash
if [ -n "$0" ]; then
	E1="LINES=$(tput lines)";
	E2="COLUMNS=$(tput cols)";
	DK_CMD="${0}";
	
	if [[ "${DK_CMD}" == "/bash_rfq" ]] || [[ "${DK_CMD}" == "/brfq" ]]; then
		# www.boneal.net
		docker exec -e "${E1}" -e "${E2}" -it "www.boneal.net" script -q -c "/bin/bash" "/dev/null";
		
	elif [[ "${DK_CMD}" == "/bash_mdev" ]] || [[ "${DK_CMD}" == "/bmdev" ]]; then
		# mdev.boneal.net
		docker exec -e "${E1}" -e "${E2}" -it "mdev.boneal.net" script -q -c "/bin/bash" "/dev/null";
		
	elif [[ "${DK_CMD}" == "/bash_rdev" ]] || [[ "${DK_CMD}" == "/brdev" ]]; then
		# rdev.boneal.net
		docker exec -e "${E1}" -e "${E2}" -it "rdev.boneal.net" script -q -c "/bin/bash" "/dev/null";
		
	elif [[ "${DK_CMD}" == "/bash_dev" ]] || [[ "${DK_CMD}" == "/bdev" ]]; then
		# dev.boneal.net
		docker exec -e "${E1}" -e "${E2}" -it "dev.boneal.net" script -q -c "/bin/bash" "/dev/null";
		
	elif [[ "${DK_CMD}" == "/bash_phpmyadmin_bnet" ]]; then
		# bnet.phpmyadmin.boneal.net  -->  Must use Alpine Linux's "/bin/busybox ash" instead of "/bin/bash"
		docker exec -e "${E1}" -e "${E2}" -it "bnet.phpmyadmin.boneal.net" "/bin/ash";

	elif [[ "${DK_CMD}" == "/bash_phpmyadmin_sg" ]]; then
		# sg.phpmyadmin.boneal.net  -->  Must use Alpine Linux's "/bin/busybox ash" instead of "/bin/bash"
		docker exec -e "${E1}" -e "${E2}" -it "sg.phpmyadmin.boneal.net" "/bin/ash";

	elif [[ "${DK_CMD}" == "/bash_dev.bonedge" ]]; then
		# dev.bonedge.boneal.net
		docker exec -e "${E1}" -e "${E2}" -it "dev.bonedge.boneal.net" script -q -c "/bin/bash" "/dev/null";

	elif [[ "${DK_CMD}" == "/bash_qa.bonedge" ]]; then
		# qa.bonedge.boneal.net
		docker exec -e "${E1}" -e "${E2}" -it "qa.bonedge.boneal.net" script -q -c "/bin/bash" "/dev/null";

	elif [[ "${DK_CMD}" == "/bash_uat.bonedge" ]]; then
		# uat.bonedge.boneal.net
		docker exec -e "${E1}" -e "${E2}" -it "uat.bonedge.boneal.net" script -q -c "/bin/bash" "/dev/null";

	elif [[ "${DK_CMD}" == "/bash_prod.bonedge" ]]; then
		# prod.bonedge.boneal.net
		docker exec -e "${E1}" -e "${E2}" -it "prod.bonedge.boneal.net" script -q -c "/bin/bash" "/dev/null";
		
	elif [[ "${DK_CMD}" == "/bash_graylog" ]] || [[ "${DK_CMD}" == "/bgraylog" ]]; then
		# graylog.boneal.net
		docker exec -e "${E1}" -e "${E2}" -it "graylog" script -q -c "/bin/bash" "/dev/null";
		
	elif [[ "${DK_CMD}" == "/bash_sonarqube" ]]; then
		# sonarqube
		docker exec -e "${E1}" -e "${E2}" -it "sonarqube" script -q -c "/bin/bash" "/dev/null";
		
	elif [[ "${DK_CMD}" == "/bash_sonarscanner" ]]; then
		# sonarscanner
		docker exec -e "${E1}" -e "${E2}" -it "sonarscanner" script -q -c "/bin/bash" "/dev/null";
		
	elif [[ "${DK_CMD}" == "/bash_postgres" ]]; then
		# postgres
		docker exec -e "${E1}" -e "${E2}" -it "postgres" script -q -c "/bin/bash" "/dev/null";
		
	else
		# unhandled bash-target
		echo "\n\n$ 0: Un-handled Bash Command: \"${0}\"\n\n";
		exit 1;
		
	fi;
else 
	echo "\n\n$ 0: Variable is either unset or contains a null value\n\n";
	exit 1;
	
fi;