#!/bin/bash
# ------------------------------------------------------------
# 
# ERLite-3  :::  Force DHCP Lease-Renewal
# 
sudo /opt/vyatta/bin/sudo-users/vyatta-clear-dhcp-lease.pl --lip=all


# ------------------------------------------------------------
#
# USG-3P (Unifi)  :::  Show DHCP Leases
#
show dhcp leases;

# ------------------------------------------------------------
#
# USG-3P (Unifi)  :::  Clear DHCP Lease(s)
#

# Clear-Lease, Step 1  :::  Clear-out "/var/run/dhcpd.leases" && "/config/dhcpd.leases"
clear dhcp leases; # Clear all leases from DHCP
IP_RELEASE_DHCP="192.168.1.100" && clear dhcp lease ip ${IP_RELEASE_DHCP}; # Clear one, specific device/ip's lease from DHCP

#
# Clear-Lease, Step 2  :::  Clear out "/var/run/dnsmasq-dhcp.leases" && "/config/dnsmasq-dhcp.leases"
/var/run/dnsmasq-dhcp.leases

# ------------------------------------------------------------
#
# USG-3P (Unifi)  :::  Force DHCP Lease-Renewal
#
sudo /opt/vyatta/bin/sudo-users/vyatta-clear-dhcp-lease.pl --lip=all --ilfile=/config/dhcpd.leases --olfile=/config/dhcpd.leases --pidf=/run/dhcpd.pid


# ------------------------------------------------------------
#
#	Citation(s)
#
# 	community.ui.com  |  "Clear DHCP Lease not working??"  |  https://community.ui.com/questions/Clear-DHCP-Lease-not-working/65494178-3e41-445f-9da5-8ed89b0a993a#answer/dbf70efc-88ed-4980-be46-d173fcc729e4
#
# ------------------------------------------------------------
