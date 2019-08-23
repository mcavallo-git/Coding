#!/bin/bash
# ------------------------------------------------------------
#
# Inspecting a running Java process
#
# ------------------------------------------------------------

# Obtain desired PID  :::  Get the PID of the Java runtime behind the local Jenkins
PID_JAVA=$(ps u -C 'java' | grep -vEi '^USER' | grep -Ei '^jenkins' | awk '{print $2}');
echo -e "\n""PID_JAVA:\n${PID_JAVA}\n"

JCMD_PID=$(sudo jcmd | awk '{print $1}'); echo -e "\n""JCMD_PID:\n${JCMD_PID}\n";
JCMD_PID_VERIFIED=$(sudo ps --format "pid,fname,user,%cpu,%mem,maj_flt,cmd" -p ${JCMD_PID} | awk '{print $1}' | grep -vEi '^PID');

JPS_PID=$(sudo jps | awk '{print $1}'); echo -e "\n""JPS_PID:\n${JPS_PID}\n";
JPS_PID_VERIFIED=$(sudo ps --format "pid,fname,user,%cpu,%mem,maj_flt,cmd" -p ${JPS_PID} | awk '{print $1}' | grep -vEi '^PID');

# ------------------------------------------------------------
# Method 1: jcmd

# List available arguments for Java process
jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" help;

# Checking assorted argument values:
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

# Method 2:
jps # shows pids

jps -l "${JCMD_PID_VERIFIED}";
jps -m "${JCMD_PID_VERIFIED}";
jps -v "${JCMD_PID_VERIFIED}"; # shows params

jps -l "localhost:${JCMD_PID_VERIFIED}";
jps -m "localhost:${JCMD_PID_VERIFIED}";
jps -v "localhost:${JCMD_PID_VERIFIED}"; # the host must be indicated

# ------------------------------------------------------------

# Method 3: 

jmap -clstats "${JCMD_PID}";

jmap -clstats "${JPS_PID}";

# ------------------------------------------------------------

# https://stackoverflow.com/a/27961336

# ------------------------------------------------------------
