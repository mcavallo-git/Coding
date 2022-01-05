#!/bin/bash

# ------------------------------------------------------------
#
# Install [ PHP v7.2 ]
#

apt-get --yes update;

apt-get --yes install "software-properties-common";

add-add-apt-repository --yes --update "ppa:ondrej/php";

apt-get --yes install "php7.2" "php7.2-cli" "php7.2-common" "php7.2-curl" "php7.2-gd" "php7.2-json" "php7.2-mbstring" "php7.2-intl" "php7.2-mysql" "php7.2-xml" "php7.2-zip";


# ------------------------------------------------------------
#
# Install [ Apache v2.4 ] && [ PHP v5.6 ] in [ Ubuntu (for WSL - Windows Subsystem for Linux) ]
#

add-apt-repository --yes --update "ppa:ondrej/php";

add-apt-repository --yes --update "ppa:ondrej/apache2";

# Install php5.6 (installs apache2 + prerequisites)
apt-get --yes install "php5.6";


# ------------------------------------------------------------
#
# Removing apache / apache2 (httpd)
#

apt-get --yes remove apache*;
apt-get --yes autoremove;
apt-get --yes clean;


# ------------------------------------------------------------
#
# Wrap-up with a set of updates/upgrades/cleaning
#

apt-get --yes update;
apt-get --yes dist-upgrade;
apt-get --yes autoremove;
apt-get --yes clean;


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
