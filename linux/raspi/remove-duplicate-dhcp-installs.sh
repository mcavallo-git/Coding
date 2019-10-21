#!/bin/bash 
#
# ------------------------------------------------------------
# Error Message received:
#		"Failed to start dhcpd on all interfaces"

# Reason: Multiple DHCP services installed

sudo dpkg -l | grep -i 'dhcp' | grep -i 'client'; # Show all client-based DHCP services

sudo apt-get remove -y dhcpcd5; # Remove unwanted DHCP service (see citation for reasoning)

# ------------------------------------------------------------
# 
#	Citation(s)
#
#	Thanks to StackExchange user [ Margin Gamza ] on forum [ https://superuser.com/a/943896 ]
#
# ------------------------------------------------------------