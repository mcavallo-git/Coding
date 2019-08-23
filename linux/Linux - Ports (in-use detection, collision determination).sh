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

echo ""; \
# ps -u 'jenkins' --format 'fname,pgid,pid,cp,size,user,%cpu,%mem,min_flt,maj_flt,cmd' --sort='fname' | grep -Ei '^COMMAND' | head -n 1
ps -u 'jenkins' --format 'fname,pgid,pid,cp,size,user,%cpu,%mem,min_flt,maj_flt,cmd' --sort='fname'; \

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


lsof -p 
COMMAND     PID            USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
jenkins   1925 36.8 30.9 6166092 1248112 ?     Sl   16:44   1:57 /usr/bin/java -
gpg --list-secret-keys --keyid-format 'LONG' | sed --regexp-extended --quiet --expression='s/^(\S+)\s+ (.*(?: \-\-httpPort=8080 ).*)$/\2/p
