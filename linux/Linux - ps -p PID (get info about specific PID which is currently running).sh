#!/bin/bash

# Linux - ps -p PID (get info about specific PID which is currently running)
PID=60010; ps -p $PID -o pid,vsz=MEMORY -o user,group=GROUP -o comm,args=ARGS;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "go - How to get process details from its pid - Stack Overflow"  |  https://stackoverflow.com/a/13780824
#
# ------------------------------------------------------------