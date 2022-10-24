#!/bin/bash
# ------------------------------------------------------------
#
# Java Inspection & Troubleshooting Tools
#  |
#  |--> Many of these commands are tools which may be found in the Java Developer's Toolkit
#
# ------------------------------------------------------------
if [[ 0 -eq 1 ]]; then

# install_java
curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -ssL "https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/main/usr/local/sbin/install_java?t=$(date +'%s.%N')" | bash;

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
# Get diagnostic info about the Jenkins service
#

#   jcmd  -->  Sends diagnostic command requests to a running Java Virtual Machine (JVM).
if [ 1 ]; then
# Note: In Cent-OS7, (as-of Apr-2020), YOU MUST CALL jcmd WHILST EITHER LOGGED-IS-AS OR MASQUERADING-AS THE SERVICE USER
SERVICE_USER="jenkins";
# Note: Command 'VM.system_properties' seems to sum things up nicely without TOO much extra info (athough it's still a lot of info)
# DIAG_REQUEST="VM.classloader_stats";
# DIAG_REQUEST="VM.classloaders";
# DIAG_REQUEST="VM.command_line";
# DIAG_REQUEST="VM.dynlibs";
# DIAG_REQUEST="VM.flags";
# DIAG_REQUEST="VM.info";
# DIAG_REQUEST="VM.log";
# DIAG_REQUEST="VM.metaspace";
# DIAG_REQUEST="VM.native_memory";
# DIAG_REQUEST="VM.print_touched_methods";
# DIAG_REQUEST="VM.set_flag";
# DIAG_REQUEST="VM.start_java_debugging";
# DIAG_REQUEST="VM.stringtable";
# DIAG_REQUEST="VM.symboltable";
DIAG_REQUEST="VM.system_properties";
# DIAG_REQUEST="VM.uptime";
# DIAG_REQUEST="VM.version";
# DIAG_REQUEST="ManagementAgent.status";
DIAG_OUTPUT="$(sudo -u ${SERVICE_USER} jcmd $(ps u -C 'java' | grep -vEi ^USER | grep -Ei ^${SERVICE_USER} | awk '{print $2}') ${DIAG_REQUEST})";
echo -e "\n${DIAG_OUTPUT}\n";
fi;


# ------------------------------------------------------------
#
#   jmap  -->  Prints shared object memory maps or heap memory details for a process, core file, or remote debug server. This command is experimental and unsupported.
#
#      -heap           Prints a heap summary of the garbage collection used, the head configuration, and generation-wise heap usage. In addition, the number and size of interned Strings are printed.
#
#      -histo[:live]   Prints a histogram of the heap. For each Java class, the number of objects, memory size in bytes, and the fully qualified class names are printed. The JVM internal class names are printed with an asterisk (*) prefix. If the live suboption is specified, then only active objects are counted.
#
#      -clstats        Prints class loader wise statistics of Java heap. For each class loader, its name, how active it is, address, parent class loader, and the number and size of classes it has loaded are printed.
#
#      -F              Force. Use this option with the jmap -dump or jmap -histo option when the pid does not respond. The live suboption is not supported in this mode.
#


# WARNING:  CLSTATS OFTEN LOCKS UP THE MACHINE & ITS SERVICE(S)
if [[ 0 -eq 1 ]]; then
	echo "Info:  Calling  [ jmap -clstats ]  which  [ Prints class loader wise statistics of Java heap. For each class loader, its name, how active it is, address, parent class loader, and the number and size of classes it has loaded are printed. ]";
	SERVICE_USER="jenkins";
	JMAP_CLSTATS="$(jmap -clstats -F $(ps u -C 'java' | grep -vEi ^USER | grep -Ei ^${SERVICE_USER} | awk '{print $2}');)";
	echo "${JMAP_CLSTATS}";
fi;

# WARNING:  HISTO OFTEN LOCKS UP THE MACHINE & ITS SERVICE(S)
if [[ 0 -eq 1 ]]; then
	echo "Info:  Calling  [ jmap -histo ]  which  [ Prints a histogram of the heap. For each Java class, the number of objects, memory size in bytes, and the fully qualified class names are printed. The JVM internal class names are printed with an asterisk (*) prefix. ]";
	SERVICE_USER="jenkins";
	JMAP_HISTO="$(jmap -histo -F $(ps u -C 'java' | grep -vEi ^USER | grep -Ei ^${SERVICE_USER} | awk '{print $2}');)";
	echo "${JMAP_HISTO}";
fi;


echo "Info:  Calling  [ jmap -heap ]  which  [ Prints a heap summary of the garbage collection used, the head configuration, and generation-wise heap usage. In addition, the number and size of interned Strings are printed. ]";
SERVICE_USER="jenkins";
JMAP_HEAP="$(jmap -heap -F $(ps u -C 'java' | grep -vEi ^USER | grep -Ei ^${SERVICE_USER} | awk '{print $2}');)";
echo "${JMAP_HEAP}";


# ------------------------------------------------------------
#
#   jps
#    |
#    |--> Lists the instrumented Java Virtual Machines (JVMs) on the target system. This command is experimental and unsupported.
#    |        (e.g. gets Java PIDs)
#    |
#    |--> >> IN-REALITY, THIS TOOL SUCKS AND IS AS USELESS AS THE MANUAL NEARLY STATES VIA "This command is experimental and unsupported." <<
# 
# 
# 	JCMD_PID=$(sudo jcmd | awk '{print $1}'); echo -e "\n""JCMD_PID:\n${JCMD_PID}\n";
# 	JCMD_PID_VERIFIED=$(sudo ps --format "pid,fname,user,%cpu,%mem,maj_flt,cmd" -p ${JCMD_PID} | awk '{print $1}' | grep -vEi '^PID');
# 
# 
# 	echo "";
# 	echo "Info:  Calling  [ jps -l \"${JCMD_PID_VERIFIED}\"; ]  which  [ Displays the full package name for the application's main class or the full path name to the application's JAR file. ]";
# 	jps -l \"${JCMD_PID_VERIFIED}\";  # Displays the full package name for the application's main class or the full path name to the application's JAR file.
# 
# 
# 	echo "";
# 	echo "Info:  Calling  [ jps -m \"${JCMD_PID_VERIFIED}\"; ]  which  [ Displays the arguments passed to the main method. The output may be null for embedded JVMs. ]";
# 	jps -m \"${JCMD_PID_VERIFIED}\";  # Displays the arguments passed to the main method. The output may be null for embedded JVMs.
# 	jps -m "${JCMD_PID_VERIFIED}";  # Displays the arguments passed to the main method. The output may be null for embedded JVMs.
# 
# 
# 	echo "";
# 	echo "Info:  Calling  [ jps -v \"${JCMD_PID_VERIFIED}\"; ]  which  [ Suppresses the output of the class name, JAR file name, and arguments passed to the main method, producing only a list of local JVM identifiers. ]";
# 	jps -v "${JCMD_PID_VERIFIED}"; # shows params
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "jvm - Command to find out -Xms and -Xmx variable values for a given java process? - Stack Overflow"  |  https://stackoverflow.com/a/27961336
#
#   stackoverflow.com  |  "linux - com.sun.tools.attach.AttachNotSupportedException: Unable to open socket file: target process not responding or HotSpot VM not loaded - Stack Overflow"  |  https://stackoverflow.com/a/51507597
#
# ------------------------------------------------------------