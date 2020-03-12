#!/bin/sh
exit 1;


### List running processes (mainly VMs) using "esxtop"
esxtop


### Press "m" to sort by memory
m


### Press "f" to add a filter
f


### Press "c" then "enter" to add the "LWID = Leader World Id (World Group Id)" column to esxtop (think of this as the PID in traditional Linux distros)
c  (enter)


### Press "k" topen the dialogue at the top of esxtop asking which LWID/WID (essentially which PID) to kill
World to kill (WID):


### Determine the process (or VM) which you wish to kill, type it (as an integer), then press enter to fire the 'kill' command
World to kill (WID): 12345 (enter)
# ^-- example: kill process with LWID of 12345


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Unable to Power off a Virtual Machine in an ESXi host (1014165)"  |  https://kb.vmware.com/s/article/1014165
#
# ------------------------------------------------------------