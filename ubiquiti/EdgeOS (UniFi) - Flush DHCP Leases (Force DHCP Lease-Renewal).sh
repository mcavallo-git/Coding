#!/bin/vbash
# ------------------------------------------------------------
#
# EdgeOS (UniFi) - Flush DHCP Leases (Force DHCP Lease-Renewal)
#


# One-liner - Flush all DHCP Leases (EdgeOS/UniFi)
FL="${HOME}/flush-dhcp-leases"; QM="$(printf \\x3f;)"; echo "LV=\"/var/run/dnsmasq-dhcp.leases\" && R1='(((25[0-5]|2[0-4][0-9]|[01]${QM}[0-9][0-9]${QM})\\.){3}(25[0-5]|2[0-4][0-9]|[01]${QM}[0-9][0-9]${QM}))' && R2='(3[0-2]|[1-2]${QM}[0-9])' && R3='(25[0-5]|2[0-4][0-9]|[01]${QM}[0-9]${QM}[0-9])' && SS=\"s/^\\\\S+_eth1_(\${R1}\\\\-\${R2})\\\\ .+\\\$/\\\\1/p\" && CR=\$(ip addr show | grep 'inet' | grep 'scope global' | awk '{ print \$2; }' | sed 's/\/.*$//' | grep '\.' | sed -rne 's/^((10|172|192)\.[0-9]{1,3}\.[0-9]{1,3})\.[0-9]{1,3}$/\1.0-24/p';) && FS=\"\${IFS}\" && IFS=\$'\\n'; for EC in \${CR}; do OT=\$(echo \"\${EC}\" | cut -d '-' -f 1 | cut -d '.' -f 1-3); SD=\"/^.+ \${OT}.\${R3} .+\\\$/d\"; sed -re \"\${SD}\" -i \"\${LV}\"; done; IFS=\"\${FS}\" && cp -f \"\${LV}\" \"/config/\$(basename \${LV})\" && service dhcpd restart && sleep 3 && clear dhcp leases && echo \"DHCP leases flushed\";" > "${FL}"; chmod 0770 "${FL}"; sudo "${FL}";


#  ^
#  |-- Note that, for some reason, question mark characters cannot be typed in EdgeOS/UniFi terminals
#       |--> To use a question mark '?' character, convert it from it's ASCII hex code via QM="$(printf \\x3f;)"
#
# ------------------------------

# Decompressed one-liner (above)'s source code
sudo -i;
if [ 1 ]; then \
LIVE_DNSMASQ_LEASES="/var/run/dnsmasq-dhcp.leases" && \
CACHE_DNSMASQ_LEASES="/config/$(basename ${LIVE_DNSMASQ_LEASES})" && \
REGEX_MATCH_IPv4_ADDRESS='(((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))' && \
REGEX_MATCH_NETMASK_BITS='(3[0-2]|[1-2]?[0-9])' && \
REGEX_MATCH_LAST_OCTET='(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])' && \
SED_SUBNET_CIDRS="s/^\\S+_eth1_(${REGEX_MATCH_IPv4_ADDRESS}\\-${REGEX_MATCH_NETMASK_BITS})\\ .+\$/\\1/p" && \
SUBNET_CIDRS="$(ip addr show | grep 'inet' | grep 'scope global' | awk '{ print $2; }' | sed 's/\/.*$//' | grep '\.' | sed -rne 's/^((10|172|192)\.[0-9]{1,3}\.[0-9]{1,3})\.[0-9]{1,3}$/\1.0-24/p';)" && \
ROLLBACK_IFS="${IFS}" && IFS=$'\n'; \
for EACH_SUBNET_CIDR in ${SUBNET_CIDRS}; do \
echo "Info:  [ Step 1 ]  Flushing DHCP leases for CIDR \"${EACH_SUBNET_CIDR}\" from cache-file \"${LIVE_DNSMASQ_LEASES}\"" && \
ETH1_NETWORK_IPv4=$(echo "${EACH_SUBNET_CIDR}" | cut -d '-' -f 1); \
ETH1_NETMASK_BITS=$(echo "${EACH_SUBNET_CIDR}" | cut -d '-' -f 2); \
ETH1_NETWORK_FIRST_THREE_OCTETS=$(echo "${ETH1_NETWORK_IPv4}" | cut -d '.' -f 1-3); \
SED_DNSMASQ_LEASES="/^.+ ${ETH1_NETWORK_FIRST_THREE_OCTETS}.${REGEX_MATCH_LAST_OCTET} .+\$/d"; \
sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -re "${SED_DNSMASQ_LEASES}" "${LIVE_DNSMASQ_LEASES}"; \
done; \
IFS="${ROLLBACK_IFS}" && \
echo "Info:  [ Step 2 ]  Copying file \"${LIVE_DNSMASQ_LEASES}\" over file \"${CACHE_DNSMASQ_LEASES}\"" && \
cp -f "${LIVE_DNSMASQ_LEASES}" "${CACHE_DNSMASQ_LEASES}" && \
service dhcpd restart && \
sleep 3 && \
echo "Info:  [ Step 3 ]  Flushing contents of cache-files '/var/run/dhcpd.leases' && '/config/dhcpd.leases'" && \
clear dhcp leases && \
echo "Info:  Done - All DHCP leases have been flushed"; \
fi;

# SUBNET_CIDRS=$(show dhcp statistics | sed -rne "${SED_SUBNET_CIDRS}";) && \


# SUBNET_CIDR=$(show dhcp statistics | sed -rne "s/^\S+_eth1_((((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\-(3[0-2]|[1-2]?[0-9]))\ .+$/\1/p";)


# ------------------------------------------------------------
#
#   Unifi USG-3P  :::  If you want to snipe one, specific DHCP lease (& make it expire) without touching the majority of the live DHCP leases
#

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


# REGEX_MATCH_LAST_OCTET='2(5[0-5]|[0-4][0-9])' && \                    # 200 - 255    (last octet of ipv4)
# REGEX_MATCH_LAST_OCTET='1[0-9]{2}' && \                               # 100-199      (last octet of ipv4)
# REGEX_MATCH_LAST_OCTET='[0-9]?[0-9]' && \                             # 0-99         (last octet of ipv4)
# REGEX_MATCH_LAST_OCTET='(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])' && \  # 0-255         (last octet of ipv4)


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.ui.com  |  "Clear DHCP Lease not working??"  |  https://community.ui.com/questions/Clear-DHCP-Lease-not-working/65494178-3e41-445f-9da5-8ed89b0a993a#answer/dbf70efc-88ed-4980-be46-d173fcc729e4
#
#   community.ui.com  |  "MAC filtering on UniFi | Ubiquiti Community"  |  https://community.ui.com/questions/MAC-filtering-on-UniFi/e181bbab-6946-466f-b315-13d96557f25e#answer/e7fd1426-8fb7-43fe-ba38-bedb3b67b848
#
# ------------------------------------------------------------