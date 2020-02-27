#!/bin/bash
#
# Setting up Kernel Crash Dump logging for use during RCA auditing workflows
#
# ------------------------------------------------------------
#
# Install the kernel crash dump logging module
#

if [ $(which kdump 2>'/dev/null' | wc -l;) -gt 0 ]; then
	if [ $(which apt 2>'/dev/null' | wc -l;) -gt 0 ]; then # Distros: Debian, Ubuntu, etc.
		apt-get -y install linux-crashdump;
	elif [ $(which yum 2>'/dev/null' | wc -l;) -gt 0 ]; then # Distros: Fedora, Oracle Linux, Red Hat Enterprise Linux, CentOS, etc.
		yum -y install kexec-tools;
	fi;
fi;


# Verify that taget service is enabled
if [ "$(systemctl is-enabled kdump.service > /dev/null 2>&1; echo $?;)" != "0" ]; then
	systemctl enable kdump.service;
fi;

# Verify that taget service is active
if [ "$(systemctl is-active kdump.service > /dev/null 2>&1; echo $?;)" != "0" ]; then
	systemctl start kdump.service;
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   access.redhat.com  |  "Chapter 7. Kernel crash dump guide Red Hat Enterprise Linux 7 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/kernel_crash_dump_guide
#
#   help.ubuntu.com  |  "Kernel Crash Dump"  |  https://help.ubuntu.com/lts/serverguide/kernel-crash-dump.html
#
# ------------------------------------------------------------