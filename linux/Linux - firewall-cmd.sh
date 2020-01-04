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
# Service - Show firewall details for a given service
firewall-cmd --info-service http;
firewall-cmd --info-service docker-swarm;


### Services - Show details for ALL services
for EACH_FIREWALL_SERVICE in $(firewall-cmd --get-services | tr ' ' '\n' | sort;); do echo "------------------------------------------------------------"; firewall-cmd --info-service="${EACH_FIREWALL_SERVICE}"; done;

###   Services - enable a service:
firewall-cmd --add-service=http;
###   Services - enable multiple services, simultaneously:
firewall-cmd --add-service={http,https};  # NOTE: this command seems unpredictable when using variables, such as --add-service="{${SERVICES}}"

###   Services - disable a service:
firewall-cmd --remove-service=http;

###
###   Custom Services - create a new service:
###     firewall-cmd --permanent --new-service=dat_service
###
###   Custom Services - delete an existing service:
###     firewall-cmd --permanent --delete-service=dat_service
###
###   Custom Services - configure a service:
###     firewall-cmd --permanent --service=dat_service --set-description=description
###     firewall-cmd --permanent --service=dat_service --set-short=description
###     firewall-cmd --permanent --service=dat_service --add-port=portid[-portid]/protocol
###     firewall-cmd --permanent --service=dat_service --add-protocol=protocol
###     firewall-cmd --permanent --service=dat_service --add-source-port=portid[-portid]/protocol
###     firewall-cmd --permanent --service=dat_service --add-module=module
###     firewall-cmd --permanent --service=dat_service --set-destination=ipv:address[/mask]
###


###   Ex)  Create a custom service for MinIO
firewall-cmd --permanent --new-service=minio;
firewall-cmd --permanent --service=minio --set-short="minio" --add-port=9000/tcp;
firewall-cmd --permanent --zone=public --add-service=minio;
firewall-cmd --set-default-zone=public;
firewall-cmd --reload;
firewall-cmd --info-service minio;
firewall-cmd --list-all;


###   Ex)  Delete a given service entirely ( !! WARNING: service will need to be recreated manually to use it again !! )
firewall-cmd --permanent --delete-service=minio;
firewall-cmd --reload;
firewall-cmd --info-service minio;
firewall-cmd --list-all;


# ------------------------------------------------------------
### Ports - Open individual ports
firewall-cmd --permanent --add-port={80,443}/tcp;
firewall-cmd --reload;
firewall-cmd --list-all;


### Ports - Close individual ports
firewall-cmd --permanent --remove-port={80,443}/tcp;
firewall-cmd --reload;
firewall-cmd --list-all;


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