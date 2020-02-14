#!/bin/bash


Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "ktpass | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/ktpass
#
#   mikefrobbins.com  |  "Use PowerShell to Install the Remote Server Administration Tools (RSAT) on Windows 10 version 1809 – Mike F Robbins"  |  https://mikefrobbins.com/2018/10/03/use-powershell-to-install-the-remote-server-administration-tools-rsat-on-windows-10-version-1809/
#
# ------------------------------------------------------------