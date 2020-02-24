#!/bin/bash
exit 1;

# Kill outgoing ssh connections
for EACH_PID in $(ps -ef | grep -v grep | grep 'ssh -i' | awk '{print $2}'); do kill ${EACH_PID}; done;

