#!/bin/bash
exit 1;

# Kill a linux process
PID="PID_TO_KILL_AS_INTEGER"; kill ${PID};


# Example: Kill all java processes
for EACH_PID in $(ps -ef | grep 'java' | grep -v 'grep' | awk '{print $2}'); do kill ${EACH_PID}; done;

