#!/bin/bash

# ------------------------------------------------------------

### Get LAN Gateway IPv4
GATEWAY_LAN_IPV4=$(ip route|grep 'default via '|sed --quiet --regexp-extended --expression="s/^default\s+via\s+([0-9a-fA-F\:\.]+)\s+[a-zA-Z0-9]+\s+([a-zA-Z0-9]+).+$/\1/p");

### Get LAN NIC (by-name)
THIS_LAN_NIC=$(ip route|grep 'default via '|sed --quiet --regexp-extended --expression="s/^default\s+via\s+([0-9a-fA-F\:\.]+)\s+[a-zA-Z0-9]+\s+([a-zA-Z0-9]+).+$/\2/p");

### Get LAN IPv4 / IPv6
THIS_LAN_IPV4=$(ip addr show ${THIS_LAN_NIC} | grep inet | awk '{ print $2; }' | sed 's/\/.*$//' | grep '\.');
THIS_LAN_IPV6=$(ip addr show ${THIS_LAN_NIC} | grep inet | awk '{ print $2; }' | sed 's/\/.*$//' | grep '\:');

echo "GATEWAY_LAN_IPV4=${GATEWAY_LAN_IPV4}";
echo "THIS_LAN_NIC=${THIS_LAN_NIC}";
echo "THIS_LAN_IPV4=${THIS_LAN_IPV4}";
echo "THIS_LAN_IPV6=${THIS_LAN_IPV6}";


#### Note: $LAN_... queries obtained through trial and error using cloud-providers: AWS, Azure, & Linode as well as local WSL (MCavallo, 2019-07-04 03:25:03)

### Previous Method - Get LAN IPv4 (obtained through trial and error using cloud-providers: AWS, Azure, & Linode as well as local WSL)
# THIS_LAN_IPV4=$(ip addr show ${THIS_LAN_NIC} | grep inet | awk '{ print $2; }' | sed 's/\/.*$//' | grep '\.');


# ------------------------------------------------------------

### etc. Methods


# ifconfig

# ip addr show



# ip neigh

# ip -oneline -4 'link' | grep 'state UP';



# ------------------------------------------------------------
#
# Citation(s)
#
# 	opensource.com  |  "How to find your IP address in Linux"  |  https://opensource.com/article/18/5/how-find-ip-address-linux
#