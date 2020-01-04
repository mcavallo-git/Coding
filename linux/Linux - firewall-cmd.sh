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


# ------------------------------------------------------------
# Print currently active zones altogether with interfaces and sources used in these zones. Active zones are zones, that have a binding to an interface or source
firewall-cmd --get-active-zones;


# ------------------------------------------------------------
# Services
for EACH_FIREWALL_SERVICE in $(firewall-cmd --get-services | tr ' ' '\n' | sort;); do echo "------------------------------------------------------------"; firewall-cmd --info-service="${EACH_FIREWALL_SERVICE}"; done;

### Create a custom service
###   firewall-cmd --permanent --new-service=myservice
###   firewall-cmd --permanent --service=myservice --set-description=description
###   firewall-cmd --permanent --service=myservice --set-short=description
###   firewall-cmd --permanent --service=myservice --add-port=portid[-portid]/protocol
###   firewall-cmd --permanent --service=myservice --add-protocol=protocol
###   firewall-cmd --permanent --service=myservice --add-source-port=portid[-portid]/protocol
###   firewall-cmd --permanent --service=myservice --add-module=module
###   firewall-cmd --permanent --service=myservice --set-destination=ipv:address[/mask]


# ------------------------------------------------------------
# ICMP Types
LOGFILE_ICMP_TYPES="${HOME}/firewall-cmd.get-icmptypes.$(hostname).log";
firewall-cmd --get-icmptypes | tr " " "\n" > "${LOGFILE_ICMP_TYPES}";


# ------------------------------------------------------------

# Ex) List all firewall-cmd rules, then allow traffic for SSH (22) & MongoDB (27017) Ports, restart the firewall service, then list all rules again
firewall-cmd --set-default-zone=public && \
firewall-cmd --permanent --zone=public --add-service={ssh,mongodb} && \
firewall-cmd --reload && \
firewall-cmd --list-all;


# ------------------------------------------------------------
# Citation(s)
# 
#   digitalocean.com  |  "How To Set Up a Firewall Using FirewallD on CentOS 7"  |  https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos-7
#
#   firewalld.org  |  "Documentation - HowTo - Add a Service | firewalld"  |  https://firewalld.org/documentation/howto/add-a-service.html
# 
#   manpages.debian.org  |  "firewall-cmd - firewalld command line client"  |  https://manpages.debian.org/testing/firewalld/firewall-cmd.1.en.html
# 
# ------------------------------------------------------------