#    Image Inspect   -   by Cavalol
#				Requires a single argument be passed via command line, ex)   ./docker_sweep.sh boneal_rfq
# 				1.  Shows sensitive data held within docker images

#!/bin/bash
if [ "$#" -ne 1 ]; then
	printf "\n   ERROR ::: MISSING FIRST PARAMETER";
	printf "\n                        Example Use:      ./image_inspect.sh centos  \n";
else 
	docker inspect $(docker images --all | grep '${1}' | awk '{print $3}');
fi;
printf "\n";
exit 0
