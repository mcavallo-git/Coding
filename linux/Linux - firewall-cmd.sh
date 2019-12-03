#!/bin/bash
# ------------------------------------------------------------
#
# Ensure the firewall is enabled & actively running
#

systemctl enable firewalld;
systemctl start firewalld;


# ------------------------------------------------------------

# List everything added for or enabled in zone. If zone is omitted, default zone will be used
firewall-cmd --list-all;

# Print currently active zones altogether with interfaces and sources used in these zones. Active zones are zones, that have a binding to an interface or source
firewall-cmd --get-active-zones;

# List known services
firewall-cmd --get-services | tr " " "\n" > ~/firewall-cmd.get-services.$(hostname).log;

# List known icmptypes
firewall-cmd --get-icmptypes | tr " " "\n" > ~/firewall-cmd.get-icmptypes.$(hostname).log;


# ------------------------------------------------------------

# Ex) List all firewall-cmd rules, then allow traffic for SSH (22) & MongoDB (27017) Ports, restart the firewall service, then list all rules again
firewall-cmd --set-default-zone=public;
firewall-cmd --permanent --zone=public --add-service={ssh,mongodb};
firewall-cmd --reload;
firewall-cmd --list-all;


# ------------------------------------------------------------
# Citation(s)
# 
#   digitalocean.com  |  "How To Set Up a Firewall Using FirewallD on CentOS 7"  |  https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos-7
# 
#   manpages.debian.org  |  "firewall-cmd - firewalld command line client"  |  https://manpages.debian.org/testing/firewalld/firewall-cmd.1.en.html
# 
# ------------------------------------------------------------