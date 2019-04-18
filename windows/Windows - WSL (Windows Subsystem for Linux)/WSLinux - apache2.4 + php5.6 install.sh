#!/bin/bash

# ------------------------------------------------------------

# Install [ Apache v2.4 ] && [ PHP v5.6 ] in [ Ubuntu (for WSL - Windows Subsystem for Linux) ]

add-apt-repository -y ppa:ondrej/php;
add-apt-repository -y ppa:ondrej/apache2;

apt-get update -y;

# Install php5.6 (installs apache2 + prerequisites)
apt-get install -y php5.6;

# ------------------------------------------------------------

# Make sure Apache Webserver isn't running, yet
service apache2 status; service apache2 stop;

# ------------------------------------------------------------

# Determine the Windows User who is hosting this WSL instance
source "./WSLinux - determine host username.sh";
WSL_HOST_USERNAME="${EXACT_MATCH}";

# Create webroot-directory within the Windows filesystem - symlink it to
# the WSL instance (allows for simplified access/modification of code)

APACHE_WEBROOT_WINDOWS="/mnt/c/Users/${WSL_HOST_USERNAME}/Documents/server";
APACHE_WEBROOT_WSL="/var/www/apache2_webroot";

mkdir -p "${APACHE_WEBROOT_WINDOWS}";
ln -sf "${APACHE_WEBROOT_WINDOWS}" "${APACHE_WEBROOT_WSL}";

# ------------------------------------------------------------
#
# Update Apache's configuration to refer to the newly created webroot-directory
#
APACHE_VHOST_CONF="/etc/apache2/sites-available/000-default.conf";
#
#			>>>> .... PERFORM STRING REPLACEMENT - WEBROOT DIRECTORY PATH, ETC. TO SYMLINKS WHICH WE MUST CREATE.... <<<<
#
ln -sf "${APACHE_VHOST_CONF}" "/etc/apache2/sites-enabled/000-default.conf";

# ------------------------------------------------------------

# Add additional files to be included into apache's runtime config
#	( virtual hosts, additional configs, etc. )
#
# ln -sf "/mnt/c/Users/${WSL_HOST_USERNAME}/conf-available/virtual_host.conf" "/etc/apache2/conf-available/virtual_host.conf";
# 	ln -sf "/etc/apache2/conf-available/virtual_host.conf" "/etc/apache2/conf-enabled/virtual_host.conf";
#

WSL_DIRNAME="CanonicalGroupLimited.UbuntuonWindows_12abcd3efghij";

WSL_ROOT_PATH="/mnt/c/Users/${WSL_HOST_USERNAME}/AppData/Local/Packages/${WSL_DIRNAME}/LocalState/rootfs/";

# ------------------------------------------------------------

# Start Apache Webserver
service apache2 start;

# ------------------------------------------------------------
#		
#		Citation(s)
#		
#		"How to set up a PHP development environment on Windows Subsystem for Linux (WSL)"
#			https://medium.freecodecamp.org/setup-a-php-development-environment-on-windows-subsystem-for-linux-wsl-9193ff28ae83
#		
# ------------------------------------------------------------
