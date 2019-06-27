#!/bin/bash
#
# -------------------------------------------------------------
# Ubuntu 16.04
#
# Download the Microsoft repository GPG keys
wget -q "https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb";
#
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb;
#
# Update the list of products
sudo apt update -y;
#
# Install PowerShell
sudo apt install -y "powershell";
#
# Redirect "powershell" to use "pwsh" command
sudo ln -sf $(readlink -f $(which pwsh)) "/usr/bin/powershell";

# Start PowerShell
# pwsh;
#
# -------------------------------------------------------------
#
# Citation(s)
#
#		docs.microsoft.com
#			"Installing PowerShell Core on Linux"
#			 https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux
#
# ------------------------------------------------------------