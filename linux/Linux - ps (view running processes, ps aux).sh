#!/bin/sh

#------------------------------------------------------------
#
# view all running processes

# ps aux;
# ^-- this is NOT the same as [ ps -aux ] - do not add any dashes to the arguments list of 'aux'

ps -A \
--format 'fname,user,pid,%cpu,%mem,drs,rss,maj_flt,cmd' \
--sort='user,fname';



# ------------------------------------------------------------
#
#	Match a specific process-name, process runtikme-user, etc.
#  |--> return any associated process-id(s) found to match


PROC_CMD="rsyslogd"; \
PROC_USER="syslog"; \
PROC_FORMAT="fname,user,pid,%cpu,%mem,maj_flt,cmd"; \
PROC_GET_COLNO="3"; \
PROC_RESULTS=$( \
ps -A --format "${PROC_FORMAT}" \
| sed --regexp-extended --quiet --expression='s/^('${PROC_CMD:-\S+}')\s+('${PROC_USER:-\S+}')\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+).*$/\'${PROC_GET_COLNO}'/p' \
); \
echo -e "\n\nPROC_RESULTS:"; \
echo -e "${PROC_RESULTS}\n\n";



# ------------------------------------------------------------
#
#	get the absolute path (of a running process)

sudo ls -l /proc/PID/exe;



# ------------------------------------------------------------
#
#	get the working directory (of a running process)

pwdx $pid;



# ------------------------------------------------------------
#
# Determine linux-user running a given process
#
# Ex) Determine user running the Jenkins service

PS_AUX_COMMAND_CONTAINS="jenkins.war";
PS_AUX_MATCHED_LINES=$(ps aux | grep '/usr/bin/daemon' | grep "${PS_AUX_COMMAND_CONTAINS}");

PROCESS_UNAME=$(echo "${PS_AUX_MATCHED_LINES}" | awk {'print $1'});
PROCESS_GNAME=$(id -gn ${PROCESS_UNAME});
PROCESS_GID=$(id -g ${PROCESS_UNAME});
PROCESS_UID=$(id -u ${PROCESS_UNAME});

echo ""; \
echo -e "PS_AUX_MATCHED_LINES\n${PS_AUX_MATCHED_LINES}"; \
echo ""; \
echo "PROCESS_UNAME = ${PROCESS_UNAME}"; \
echo "PROCESS_GNAME = ${PROCESS_GNAME}"; \
echo "PROCESS_GID = ${PROCESS_GID}"; \
echo "PROCESS_UID = ${PROCESS_UID}"; \
echo "";



# ------------------------------------------------------------
# > man ps
#
#  ...
#        a      Lift the BSD-style "only yourself" restriction, which is imposed upon the set of all processes when
#               some BSD-style (without "-") options are used or when the ps personality setting is BSD-like.  The set
#               of processes selected in this manner is in addition to the set of processes selected by other means.
#               An alternate description is that this option causes ps to list all processes with a terminal (tty), or
#               to list all processes when used together with the x option.
#  ...
#        u      Display user-oriented format.
#  ...
#        x      Lift the BSD-style "must have a tty" restriction, which is imposed upon the set of all processes when
#               some BSD-style (without "-") options are used or when the ps personality setting is BSD-like.  The set
#               of processes selected in this manner is in addition to the set of processes selected by other means.
#               An alternate description is that this option causes ps to list all processes owned by you (same EUID as
#               ps), or to list all processes when used together with the a option.
#  ...
#
# ------------------------------------------------------------
#
#	Citation(s)
#
#		Thanks to StackOverflow user [ Sebastian Smolorz ] on forum [ https://stackoverflow.com/questions/17733671 ] ( determine jenkins service's runtime user )
#
#		Thanks to StackOverflow user [ akira ] on forum [ https://superuser.com/questions/103309 ] ( absolute path of a running process )
#
#		Thanks to StackOverflow user [ seenu ] on forum [ https://superuser.com/questions/103309 ] ( working directory of a running process )
#
# ------------------------------------------------------------