#!/bin/bash

# ------------------------------------------------------------

### Get LAN Gateway IPv4
GATEWAY_LAN_IPV4=$(ip route|grep 'default via '|sed --quiet --regexp-extended --expression="s/^default\s+via\s+([0-9a-fA-F\:\.]+)\s+[a-zA-Z0-9]+\s+([a-zA-Z0-9]+).+$/\1/p");
### Get LAN NIC (by-name)
THIS_LAN_NIC=$(ip route|grep 'default via '|sed --quiet --regexp-extended --expression="s/^default\s+via\s+([0-9a-fA-F\:\.]+)\s+[a-zA-Z0-9]+\s+([a-zA-Z0-9]+).+$/\2/p");
### Get LAN IPv4 (obtained through trial and error using cloud-providers: AWS, Azure, & Linode as well as local WSL)
### THIS_LAN_IPV4=$(ip -o -4 address|grep ': eth'|grep '/2'|sed --quiet --regexp-extended --expression="s/^[0-9]+:\s+([a-zA-Z0-9\-]+)\s+inet\s+([0-9a-fA-F\:\.]+)\/([0-9]+)\s+.+$/\2/p");
THIS_LAN_IPV4=$(ip -o -4 address | grep ": ${THIS_LAN_NIC}"|sed --quiet --regexp-extended --expression="s/^[0-9]+:\s+([a-zA-Z0-9\-]+)\s+inet\s+([0-9a-fA-F\:\.]+)\/([0-9]+)\s+.+$/\2/p");
echo "GATEWAY_LAN_IPV4=${GATEWAY_LAN_IPV4}"; \
echo "THIS_LAN_NIC=${THIS_LAN_NIC}"; \
echo "THIS_LAN_IPV4=${THIS_LAN_IPV4}";


#### Note: $LAN_... queries obtained through trial and error using cloud-providers: AWS, Azure, & Linode as well as local WSL (MCavallo, 2019-07-04 03:25:03)



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