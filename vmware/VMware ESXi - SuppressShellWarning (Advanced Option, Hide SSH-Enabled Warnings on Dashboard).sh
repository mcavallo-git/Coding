#!/bin/sh


# Linux - ESXi, SuppressShellWarning (Advanced Option, Hide SSH-Enabled Warnings on Dashboard)


esxcfg-advcfg -g "/UserVars/SuppressShellWarning";  # Check if SSH warning is enabled (0) or suppressed (1)


esxcfg-advcfg -s 0 "/UserVars/SuppressShellWarning";  # Display the "SSH is enabled on this host..." warning (ESXi 6.0.0 default value)


esxcfg-advcfg -s 1 "/UserVars/SuppressShellWarning";  # Suppress the "SSH is enabled on this host..." warning


/etc/init.d/hostd restart;  # Restart the [ ESXi host daemon ] service (should be accessible again within ~15-30 seconds) Note: Doesn't affect any VMs


# ------------------------------------------------------------
# As a one-liner (HIDE WARNINGS)

esxcfg-advcfg -g "/UserVars/SuppressShellWarning"; esxcfg-advcfg -s 1 "/UserVars/SuppressShellWarning"; /etc/init.d/hostd restart;


# ------------------------------------------------------------
# As a one-liner (SHOW WARNINGS)
# 
# esxcfg-advcfg -g "/UserVars/SuppressShellWarning"; esxcfg-advcfg -s 0 "/UserVars/SuppressShellWarning"; /etc/init.d/hostd restart;
# 
# 
# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Configuring advanced options for ESXi/ESX (1038578)"  |  https://kb.vmware.com/s/article/1038578
#
#   vswitchzero.com  |  "Suppressing ESXi Shell and SSH Warnings"  |  https://vswitchzero.com/2017/06/03/suppressing-esxi-shell-and-ssh-warnings/
# 
# ------------------------------------------------------------