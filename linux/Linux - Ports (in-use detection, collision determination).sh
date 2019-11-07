#!/bin/bash

# List ports in use
lsof -i -P -n | grep 'LISTEN';

# Show all items using port 443
fuser -k 443/tcp;

# Kill all items using port 443
fuser -k 443/tcp;

# List all --format column-options within  [ ps ]  ( example: ps aux --format pid,format,state,tname,time,command )
ps L;

# Locate processes which match the following variable declarations:

PROC_CMD="java"; \
PROC_USER="jenkins"; \
PROC_FORMAT="fname,user,pid,%cpu,%mem,maj_flt,cmd"; \
PROC_GET_COLNO="3"; \
PROC_ROW_CONTAINS="8080"; \
PROC_RESULTS_PS=$(ps -A --format "${PROC_FORMAT}" | grep -v 'color=auto' | grep "${PROC_ROW_CONTAINS}" | sed --regexp-extended --quiet --expression='s/^('${PROC_CMD:-\S+}')\s+('${PROC_USER:-\S+}')\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+).*$/\'${PROC_GET_COLNO}'/p' | head -n 1;); \
PROC_RESULTS_LSOF=$(lsof -i -P -n | grep "${PROC_ROW_CONTAINS}" | grep "${PROC_CMD}" | awk '{print $2}';); \
if [ -z "${PROC_RESULTS_PS}" ] && [ -z "${PROC_RESULTS_LSOF}" ]; then \
	echo ""; \
	echo "Error: No PIDs found for jenkins"; \
	echo "Calling [ service jenkins restart; sleep 2; ]..."; \
	service jenkins restart; sleep 2; \
	echo ""; \
fi; \
PROC_RESULTS_PS=$(ps -A --format "${PROC_FORMAT}" | grep -v 'color=auto' | grep "${PROC_ROW_CONTAINS}" | sed --regexp-extended --quiet --expression='s/^('${PROC_CMD:-\S+}')\s+('${PROC_USER:-\S+}')\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+).*$/\'${PROC_GET_COLNO}'/p' | head -n 1;); \
PROC_RESULTS_LSOF=$(lsof -i -P -n | grep "${PROC_ROW_CONTAINS}" | grep "${PROC_CMD}" | awk '{print $2}';); \
echo -e "\n""PROC_RESULTS_PS:\n${PROC_RESULTS_PS}\n"; ps --format "${PROC_FORMAT}" -p "${PROC_RESULTS_PS}"; echo -e "\n\n"; \
echo -e "\n""PROC_RESULTS_LSOF:\n${PROC_RESULTS_LSOF}\n"; ps --format "${PROC_FORMAT}" -p "${PROC_RESULTS_LSOF}"; echo -e "\n\n"; \
echo "Calling [ kill \"${PROC_RESULTS_LSOF}\" \"${PROC_RESULTS_PS}\"; ]..."; \
kill "${PROC_RESULTS_LSOF}" "${PROC_RESULTS_PS}"; \
echo "Calling [ service jenkins restart; ]..."; \
service jenkins restart;
