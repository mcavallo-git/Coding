#!/bin/bash

# List ports in use
lsof -i -P -n | grep 'LISTEN';

# Show all items using port 443
fuser -k 443/tcp;

# Kill all items using port 443
fuser -k 443/tcp;

# List all --format column-options within  [ ps ]  ( example: ps aux --format pid,format,state,tname,time,command )
ps L;

# Compare running-processes to actively-listening ports for any process containing the name [ java ]
# | awk '{print $2}'

# ps aux | grep '%MEM' | awk '{print $2}'; \
# ps u -A -U 'jenkins' --format user,pid,%cpu,%mem,command,bsdstart,lstart,start_time,time --sort=%cpu;
# ps -u 'jenkins' --format 'fname,pid,user,%cpu,%mem,maj_flt,cmd' --sort='fname' | grep -Ei '^COMMAND' | head -n 1

echo ""; \
ps -u 'jenkins' --format 'fname,user,pid,%cpu,%mem,maj_flt,cmd' --sort='fname' | grep -Ei '^COMMAND' | head -n 1; \

PROC_CMD="java";
PROC_USER="jenkins";
PROC_FORMAT="fname,user,pid,%cpu,%mem,maj_flt,cmd";
PROC_GET_COLNO="3"; # pid
PROC_PIDS=$( \
ps -A --format "${PROC_FORMAT}" \
| sed --regexp-extended --quiet --expression='s/^('${PROC_CMD:-\S+}')\s+('${PROC_USER:-\S+}')\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+).*$/\'${PROC_GET_COLNO}'/p' \
);
echo "PROC_PIDS:";
echo "${PROC_PIDS}";

echo ""; \
lsof -i -P -n | grep 'SIZE/OFF' | awk '{print $2}'; \
lsof -i -P -n | grep '*:8080 (LISTEN)' | grep 'java' | awk '{print $2}'; \
echo "";

# echo ""; \
# ps aux | grep '%MEM'; \
# ps aux | grep 'java' | grep -v 'color'; \
# echo ""; \
# lsof -i -P -n | grep 'SIZE/OFF'; \
# lsof -i -P -n | grep 'LISTEN' | grep 'java' | grep '*:8080 (LISTEN)'; \
# echo "";

