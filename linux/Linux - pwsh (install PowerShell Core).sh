#!/bin/bash

OS_VERSION_MAJOR=$(cat /etc/*release | grep -i VERSION_ID | sed --regexp-extended --quiet --expression='s/^VERSION_ID="([0-9]+)\.([0-9]+)"$/\1/p');
OS_VERSION_MINOR=$(cat /etc/*release | grep -i VERSION_ID | sed --regexp-extended --quiet --expression='s/^VERSION_ID="([0-9]+)\.([0-9]+)"$/\2/p');

if [[ ${OS_VERSION_MAJOR} -ge 18 ]]; then
# UBUNTU 18+
wget -q "https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb"; # Download the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb; # Register the Microsoft repository GPG keys
sudo apt-get update -y; # Update the list of products
sudo add-apt-repository "universe"; # Enable the "universe" repositories
sudo apt-get install -y powershell; # Install PowerShell

elif [[ ${OS_VERSION_MAJOR} -lt 18 ]] && [[ ${OS_VERSION_MAJOR} -ge 16 ]]; then
# UBUNTU 16+
wget -q "https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb"; # Download the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb; # Register the Microsoft repository GPG keys
sudo apt-get update -y; # Update the list of products
sudo apt-get install -y "powershell"; # Install PowerShell
sudo ln -sf $(readlink -f $(which pwsh)) "/usr/bin/powershell"; # Redirect "powershell" to use "pwsh" command

elif [[ ${OS_VERSION_MAJOR} -lt 16 ]] && [[ ${OS_VERSION_MAJOR} -ge 14 ]]; then
# UBUNTU 14+
wget -q "https://packages.microsoft.com/config/ubuntu/14.04/packages-microsoft-prod.deb"; # Download the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb # Register the Microsoft repository GPG keys
sudo apt-get update -y; # Update the list of products
sudo apt-get install -y "powershell"; # Install PowerShell

else
# UNKNOWN/UNHANDLED
echo "";
echo "Unhandled version of Linux";
echo "";
echo "Please see Microsoft's tutorial page for installing PowerShell Core @:";
echo " |    ";
echo " |--> https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux";

fi;

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