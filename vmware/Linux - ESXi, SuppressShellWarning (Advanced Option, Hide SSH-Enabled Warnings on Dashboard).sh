#!/bin/bash


# Linux - ESXi, SuppressShellWarning (Advanced Option, Hide SSH-Enabled Warnings on Dashboard)


esxcfg-advcfg -g "/UserVars/SuppressShellWarning";  # Check if SSH warning is enabled (0) or suppressed (1)


esxcfg-advcfg -s 1 "/UserVars/SuppressShellWarning";  # Suppress the "SSH is enabled on this host..." warning


esxcfg-advcfg -s 0 "/UserVars/SuppressShellWarning";  # Display the "SSH is enabled on this host..." warning


# ------------------------------------------------------------
# Citation(s)
#
#   vswitchzero.com  |  "Suppressing ESXi Shell and SSH Warnings"  |  https://vswitchzero.com/2017/06/03/suppressing-esxi-shell-and-ssh-warnings/
# 
# ------------------------------------------------------------