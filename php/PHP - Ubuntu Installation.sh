#!/bin/bash

# ------------------------------------------------------------
#
# Install [ PHP v7.2 ]
#

apt-get update -y;

apt-get install -y software-properties-common;

add-apt-repository -y ppa:ondrej/php; apt-get update -y;

apt-get install -y php7.2 php7.2-cli php7.2-common php7.2-curl php7.2-gd php7.2-json php7.2-mbstring php7.2-intl php7.2-mysql php7.2-xml php7.2-zip;

# ------------------------------------------------------------
#
# Install [ Apache v2.4 ] && [ PHP v5.6 ] in [ Ubuntu (for WSL - Windows Subsystem for Linux) ]
#

add-apt-repository -y ppa:ondrej/php;

add-apt-repository -y ppa:ondrej/apache2;

apt-get update -y;

# Install php5.6 (installs apache2 + prerequisites)
apt-get install -y php5.6;

# ------------------------------------------------------------
#
# Removing apache / apache2 (httpd)
#

apt remove -y apache*; apt-get autoremove -y; apt-get clean -y;

# ------------------------------------------------------------
#
# Wrap-up with a set of updates/upgrades/cleaning
#

apt-get update -y; apt-get dist-upgrade -y; apt-get autoremove -y; apt-get clean -y;


# ------------------------------------------------------------
#		
#		Citation(s)
#		
#		"How to set up a PHP development environment on Windows Subsystem for Linux (WSL)"
#			https://medium.freecodecamp.org/setup-a-php-development-environment-on-windows-subsystem-for-linux-wsl-9193ff28ae83
#		
#		"How to Install PHP 7.2 on Ubuntu 16.04"
#			https://www.rosehosting.com/blog/how-to-install-php-7-2-on-ubuntu-16-04/
#		
# ------------------------------------------------------------
