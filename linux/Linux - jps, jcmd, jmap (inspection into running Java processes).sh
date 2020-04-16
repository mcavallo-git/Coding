#!/bin/bash
# ------------------------------------------------------------
#
# Java Inspection & Troubleshooting Tools
#  |
#  |--> Many of these commands are tools which may be found in the Java Developer's Toolkit
#
# ------------------------------------------------------------
if [ 0 -eq 1 ]; then

# install_java
curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -ssL "https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master/usr/local/sbin/install_java?t=$(date +'%s.%N')" | bash;


fi;
# ------------------------------------------------------------
#
# Obtain Process ID (PID) for a given java service
#

if [ 1 ]; then
SERVICE_USER="jenkins";
PID_JENKINS=$(ps u -C 'java' | grep -vEi '^USER' | grep -Ei "^${SERVICE_USER}" | awk '{print $2}');
echo -e "\n""PID_JAVA_JENKINS:\n${PID_JENKINS}\n";
fi;


# ------------------------------------------------------------
#
# Additional methods to get PID(s)
#

JCMD_PID=$(sudo jcmd | awk '{print $1}'); echo -e "\n""JCMD_PID:\n${JCMD_PID}\n";
JCMD_PID_VERIFIED=$(sudo ps --format "pid,fname,user,%cpu,%mem,maj_flt,cmd" -p ${JCMD_PID} | awk '{print $1}' | grep -vEi '^PID'); # This one changes very rapidly, should combine statements if running in a production-intensive environment

JPS_PID=$(sudo jps | awk '{print $1}'); echo -e "\n""JPS_PID:\n${JPS_PID}\n";
JPS_PID_VERIFIED=$(sudo ps --format "pid,fname,user,%cpu,%mem,maj_flt,cmd" -p ${JPS_PID} | awk '{print $1}' | grep -vEi '^PID');


# ------------------------------------------------------------
#
#   jcmd
#    |-->  Sends diagnostic command requests to a running Java Virtual Machine (JVM).
#

# Note: In Cent-OS7, (as-of Apr-2020), YOU MUST CALL jcmd WHILST EITHER LOGGED-IS-AS OR MASQUERADING-AS THE SERVICE USER
if [ 1 ]; then
# Get allowed commands
SERVICE_USER="jenkins";
DIAG_REQUEST="help";
DIAG_OUTPUT="$(sudo -u ${SERVICE_USER} jcmd $(ps u -C 'java' | grep -vEi ^USER | grep -Ei ^${SERVICE_USER} | awk '{print $2}') ${DIAG_REQUEST})";
#^-SYNTAX-^: $(sudo -u <java_pid_user> jcmd |---------------------------------->  <pid>  <-----------------------------------| <java-svc command>
echo -e "\n${DIAG_OUTPUT}\n";
fi;

# List available arguments for Java process
jcmd "$(sudo jcmd | awk '{print $1}')" help;

# Jenkins - List available arguments for Java process
PID_JAVA_JENKINS=$(ps u -C 'java' | grep -vEi '^USER' | grep -Ei '^jenkins' | awk '{print $2}'); \
jcmd "${PID_JAVA_JENKINS}" help;

# Jenkins - Checking assorted argument values:
jcmd "$(jcmd | grep jenkins | awk '{print $1}')" "VM.system_properties";

# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.classloader_stats
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.classloaders
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.command_line
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.dynlibs
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.flags
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.info
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.log
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.metaspace
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.native_memory
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.print_touched_methods
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.set_flag
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.start_java_debugging
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.stringtable
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.symboltable
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.system_properties
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.uptime
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.version

# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" ManagementAgent.status


# ------------------------------------------------------------
#
#   jps
#    |
#    |-->  Lists the instrumented Java Virtual Machines (JVMs) on the target system. This command is experimental and unsupported.
#             (e.g. gets Java PIDs)
#

jps # shows pids


JCMD_PID=$(sudo jcmd | awk '{print $1}'); echo -e "\n""JCMD_PID:\n${JCMD_PID}\n";
JCMD_PID_VERIFIED=$(sudo ps --format "pid,fname,user,%cpu,%mem,maj_flt,cmd" -p ${JCMD_PID} | awk '{print $1}' | grep -vEi '^PID');


jps -l "${JCMD_PID_VERIFIED}";
jps -m "${JCMD_PID_VERIFIED}";
jps -v "${JCMD_PID_VERIFIED}"; # shows params


jps -l "localhost:${JCMD_PID_VERIFIED}";
jps -m "localhost:${JCMD_PID_VERIFIED}";
jps -v "localhost:${JCMD_PID_VERIFIED}"; # the host must be indicated


# ------------------------------------------------------------
#
#   jmap
#    |
#    |-->  Prints shared object memory maps or heap memory details for a process, core file, or remote debug server. This command is experimental and unsupported.
#

jmap -clstats "${JCMD_PID}";

jmap -clstats "${JPS_PID}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "jvm - Command to find out -Xms and -Xmx variable values for a given java process? - Stack Overflow"  |  https://stackoverflow.com/a/27961336
#
#   stackoverflow.com  |  "linux - com.sun.tools.attach.AttachNotSupportedException: Unable to open socket file: target process not responding or HotSpot VM not loaded - Stack Overflow"  |  https://stackoverflow.com/a/51507597
#
# ------------------------------------------------------------