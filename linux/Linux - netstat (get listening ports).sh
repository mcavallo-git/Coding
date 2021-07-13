#!/bin/bash
# ------------------------------------------------------------

# netstat
#    -a, --all         Show both listening and non-listening sockets.  With the --interfaces option, show interfaces that are not up
#    --numeric, -n     Show numerical addresses instead of trying to determine symbolic host, port or user names.
#    -l, --listening   Show only listening sockets.  (These are omitted by default.)
#    -p, --program     Show the PID and name of the program to which each socket belongs.
#    --tcp|-t
#    --udp|-u


# LIST OUTGOING PORTS/SOCKETS  (TCP, ANY SOCKET TYPE (LISTEN, ESTABLISHED, TIME-WAIT, ...))
netstat -atn;

# LIST OUTGOING PORTS/SOCKETS  (UDP, ANY SOCKET TYPE (LISTEN, ESTABLISHED, TIME-WAIT, ...))
netstat -aun;

# LIST OUTGOING PORTS/SOCKETS  (TCP & UDP, ANY SOCKET TYPE (LISTEN, ESTABLISHED, TIME-WAIT, ...))
netstat -atun;

# LIST OUTGOING PORTS/SOCKETS  (TCP & UDP, ONLY LISTENING SOCKET TYPE)
netstat -tulpen;


# ------------------------------------------------------------

# Linux: Find Out Which Process Is Listening on Port 80
# netstat -tulpn; # ALL PORTS
netstat -tulpn | grep :80;
# |--> returned:   tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      8119/nginx.conf

# ------------------------------------------------------------

# Find out the processes PID that opened tcp port 80
fuser 80/tcp
# |--> returned:   80/tcp:               8119  8148  8149


# ------------------------------------------------------------

# get info regarding the program behind a PID
ls -l /proc/8119/exe
	# |--> returned:   lrwxrwxrwx 1 root root 0 May 17 10:10 /proc/8119/exe -> /usr/sbin/nginx

ls -l /proc/8148/exe
	# |--> returned:   lrwxrwxrwx 1 www-data www-data 0 May 17 10:12 /proc/8148/exe -> /usr/sbin/nginx

ls -l /proc/8149/exe
	# |--> returned:   lrwxrwxrwx 1 www-data www-data 0 May 17 10:12 /proc/8149/exe -> /usr/sbin/nginx


# Option 2: use lsof Command (get all info for processes on port 80)
# lsof -i :80


# ------------------------------------------------------------

# inspection using ps Command
# NGINX_PID=$(ps -ef | grep 'nginx' | grep -v 'grep' | awk '{print $2}');
NGINX_PID=$(ps -ef | grep 'nginx: master process' | grep -v 'grep' | awk '{print $2}');
echo "NGINX_PID=${NGINX_PID}";

THIS_DISK_SIZE="$(df -h . | grep -v Size | awk '{print $2}')";


# "I recommend the following command to grab info about pid # xxx"
# ps -eo pid,user,group,args,etime,lstart | grep nginx | grep master;
# ps -eo pid,user,group,args,etime,lstart | grep '[1]842';

ps -eo pid,user,group,args,etime,lstart | grep '[8]119';
	# |--> returned:   8119 root     root     nginx: master process nginx       28:52 Thu May 17 10:10:13 2018

ps -eo pid,user,group,args,etime,lstart | grep '[8]148';
	# |--> returned:   8148 www-data www-data nginx: worker process             28:16 Thu May 17 10:10:28 2018

ps -eo pid,user,group,args,etime,lstart | grep '[8]149';
	# |--> returned:   8149 www-data www-data nginx: worker process             28:57 Thu May 17 10:10:28 2018


# ------------------------------------------------------------

# Task: Find Out Current Working Directory Of a Process
pwdx 8119
pwdx 8148
pwdx 8149


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.cyberciti.biz  |  "Linux Find Out Which Process Is Listening Upon a Port - nixCraft"  |  https://www.cyberciti.biz/faq/what-process-has-open-linux-port/
#
# ------------------------------------------------------------