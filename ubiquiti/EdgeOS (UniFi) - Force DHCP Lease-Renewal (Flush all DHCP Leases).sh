#!/bin/bash

# ------------------------------------------------------------
#
# USG-3P (Unifi)  :::  Clear DHCP Leases - Step 1, clear-out "/var/run/dnsmasq-dhcp.leases" && "/config/dnsmasq-dhcp.leases"
#


LIVE_DNSMASQ_LEASES="/var/run/dnsmasq-dhcp.leases" && \
CACHE_DNSMASQ_LEASES="/config/$(basename ${LIVE_DNSMASQ_LEASES})" && \
REGEX_MATCH_IPv4_ADDRESS='(((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))' && \
REGEX_MATCH_NETMASK_BITS='(3[0-2]|[1-2]?[0-9])' && \
REGEX_MATCH_LAST_OCTET='(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])' && \
SUBNET_CIDR=$(show dhcp statistics \
| sed \
--regexp-extended \
--quiet \
--expression='s/^\S+_eth1_('${REGEX_MATCH_IPv4_ADDRESS}'\-'${REGEX_MATCH_NETMASK_BITS}')\ .+$/\1/p' \
;) && \
ETH1_NETWORK_IPv4=$(echo "${SUBNET_CIDR}" | cut -d '-' -f 1) && \
ETH1_NETMASK_BITS=$(echo "${SUBNET_CIDR}" | cut -d '-' -f 2) && \
ETH1_NETWORK_FIRST_THREE_OCTETS=$(echo "${ETH1_NETWORK_IPv4}" | cut -d '.' -f 1-3) && \
sed \
--regexp-extended \
--in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" \
--expression='/^.+ '${ETH1_NETWORK_FIRST_THREE_OCTETS}'.'${REGEX_MATCH_LAST_OCTET}' .+$/d' \
"${LIVE_DNSMASQ_LEASES}" && \
cp -f "${LIVE_DNSMASQ_LEASES}" "${CACHE_DNSMASQ_LEASES}" && \
service dhcpd restart \
;


# REGEX_MATCH_LAST_OCTET='2(5[0-5]|[0-4][0-9])' && \                    # 200 - 255    (last octet of ipv4)
# REGEX_MATCH_LAST_OCTET='1[0-9]{2}' && \                               # 100-199      (last octet of ipv4)
# REGEX_MATCH_LAST_OCTET='[0-9]?[0-9]' && \                             # 0-99         (last octet of ipv4)
# REGEX_MATCH_LAST_OCTET='(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])' && \  # 0-255         (last octet of ipv4)


# ------------------------------------------------------------
#
# USG-3P (Unifi)  :::  Clear DHCP Leases - Step 2, clear-out "/var/run/dhcpd.leases" && "/config/dhcpd.leases"
#

clear dhcp leases; # Clear all leases from DHCP

IP_RELEASE_DHCP="192.168.1.100" && clear dhcp lease ip ${IP_RELEASE_DHCP}; # Clear one, specific device/ip's lease from DHCP


# ------------------------------------------------------------
# 
# Side-Notes:  ERLite-3  :::  Force DHCP Lease-Renewal
# 
sudo /opt/vyatta/bin/sudo-users/vyatta-clear-dhcp-lease.pl --lip=all


# ------------------------------------------------------------
#
# Side-Notes:  USG-3P (Unifi)  :::  Show DHCP Leases
#
show dhcp leases;
show dhcp client leases interface eth0;
show dhcp client leases interface eth1;
show dhcp client leases interface eth2;
show dhcpv6 relay-agent status;


# ------------------------------------------------------------
#
# Side-Notes:  [ DEPRECATED ]  USG-3P (Unifi)  :::  Force DHCP Lease-Renewal
#
sudo /opt/vyatta/bin/sudo-users/vyatta-clear-dhcp-lease.pl --lip=all --ilfile=/config/dhcpd.leases --olfile=/config/dhcpd.leases --pidf=/run/dhcpd.pid


# ------------------------------------------------------------
#
#	Citation(s)
#
# 	community.ui.com  |  "Clear DHCP Lease not working??"  |  https://community.ui.com/questions/Clear-DHCP-Lease-not-working/65494178-3e41-445f-9da5-8ed89b0a993a#answer/dbf70efc-88ed-4980-be46-d173fcc729e4
#
# ------------------------------------------------------------
