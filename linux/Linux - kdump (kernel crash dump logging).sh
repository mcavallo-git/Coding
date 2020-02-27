#!/bin/bash
#
# Setting up Kernel Crash Dump logging for use during RCA auditing workflows
#
# ------------------------------------------------------------
#
# Install the kernel crash dump logging module
#

if [ $(which yum 2>'/dev/null' | wc -l;) -gt 0 ]; then # Distros: Fedora, Oracle Linux, Red Hat Enterprise Linux, CentOS, etc.
	### Check if kdump is installed (or not)
	# rpm -q kexec-tools
	#
	### 
	### Install kdump
	if [ $(which kdump 2>'/dev/null' | wc -l;) -gt 0 ]; then
		yum install kexec-tools;
	fi;
	### Check if kdump's GUI-based configuration module is installed (or not)
	# rpm -q system-config-kdump
	#
	### Install kdump's GUI-based configuration module
	# if [ $(which kdump 2>'/dev/null' | wc -l;) -gt 0 ]; then
	# 	yum install system-config-kdump;
	# fi;
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   access.redhat.com  |  "Chapter 7. Kernel crash dump guide Red Hat Enterprise Linux 7 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/kernel_crash_dump_guide
#
# ------------------------------------------------------------