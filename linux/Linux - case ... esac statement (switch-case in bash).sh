#!/bin/bash

# ------------------------------------------------------------
# Report file system's disk-usage w/ a case-statement
#

shopt -s lastpipe; # extends the current shell into sub-shells (within piped-commands), sharing variables down-into them, as well

unset DISK_STATS; declare -A DISK_STATS; # [Re-]Instantiate bash array

DISK_PCT_USED=`df -h --output="pcent" | sed '1!G;h;$!d' | head -n -1 | sed '1!G;h;$!d' | sort -n | tail -1 | tr -d ' ' | cut -d "%" -f1 -;`

case ${DISK_PCT_USED} in
[1-6]*)
  Message="Disk is ${DISK_PCT_USED}% Full - All is quiet."
  ;;
[7-8]*)
  Message="Disk is ${DISK_PCT_USED}% Full - Start thinking about cleaning out some stuff.  There's a partition that is $space % full."
  ;;
9[1-8])
  Message="Disk is ${DISK_PCT_USED}% Full - Better hurry with that new disk...  One partition is $space % full."
  ;;
99)
  Message="Disk is ${DISK_PCT_USED}% Full - I'm drowning here!  There's a partition at $space %!"
  ;;
*)
  Message="Disk is ${DISK_PCT_USED}% Full - I seem to be running with an nonexistent amount of disk space..."
  ;;
esac

echo $Message

# ------------------------------------------------------------
# Citation(s)
#
#   tldp.org  |  "7.3. Using case statements"  |  https://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html
#
# ------------------------------------------------------------