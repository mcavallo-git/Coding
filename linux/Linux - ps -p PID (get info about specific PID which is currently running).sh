#!/bin/bash

# Linux - ps -p PID (get info about specific PID which is currently running)
PID=60010; ps -p $PID -o pid,vsz=MEMORY -o user,group=GROUP -o comm,args=ARGS;

# Linux - ps -p PID (get info about specific PID which is currently running)
PID=60010; ps -Flww -p $PID;


# ------------------------------------------------------------
#
# Citation(s)
#
#   askubuntu.com  |  "command line - How to see detailed information about a given PID? - Ask Ubuntu"  |  https://askubuntu.com/a/831521
#
#   stackoverflow.com  |  "go - How to get process details from its pid - Stack Overflow"  |  https://stackoverflow.com/a/13780824
#
# ------------------------------------------------------------