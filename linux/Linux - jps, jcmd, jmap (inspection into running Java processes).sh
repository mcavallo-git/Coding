#!/bin/bash
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

# echo -e "\n""JCMD_PID_VERIFIED:\n${JCMD_PID_VERIFIED}\n";
# jmap -heap ${JCMD_PID_VERIFIED};

# echo -e "\n""JPS_PID_VERIFIED:\n${JPS_PID_VERIFIED}\n";
# jmap -heap <${JPS_PID_VERIFIED}>;

# ------------------------------------------------------------
# Method 1: jcmd

# List available arguments for Java process
jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" help;

# Checking assorted argument values:
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.metaspace
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.version
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.info
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.classloader_stats
# jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" ManagementAgent.status

# ------------------------------------------------------------

# Method 2:
jps # shows pids

jps -l "${JCMD_PID_VERIFIED}";
jps -m "${JCMD_PID_VERIFIED}";
jps -v "${JCMD_PID_VERIFIED}"; # shows params

jps -l "localhost:${JCMD_PID_VERIFIED}";
jps -m"localhost:${JCMD_PID_VERIFIED}";
jps -v "localhost:${JCMD_PID_VERIFIED}"; # the host must be indicated

# ------------------------------------------------------------

# Method 3: 

jmap -clstats "${JCMD_PID}";

jmap -clstats "${JPS_PID}";

# ------------------------------------------------------------

# https://stackoverflow.com/a/27961336

# ------------------------------------------------------------
