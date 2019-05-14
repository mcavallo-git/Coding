#!/bin/bash
#    Docker Volume Pruner   -   by Cavalol
# 				Prunes all Unused Docker-Volumes

echo -e "\nDocker Volume-Pruner -   Performing PRUNE on all Dangling volumes...\n"; docker volume prune -f; echo "";

exit;
