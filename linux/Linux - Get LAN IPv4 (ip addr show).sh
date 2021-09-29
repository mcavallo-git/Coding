#!/bin/bash

# Get ALL IPv4 addresses attached to local NICs
THIS_IPV4_ADDR_ALL=$(ip addr show | grep 'inet' | grep 'scope global' | awk '{ print $2; }' | sed 's/\/.*$//' | grep '\.');
echo "THIS_IPV4_ADDR_ALL=[ ${THIS_IPV4_ADDR_ALL} ]";


# Get only Private IPv4 addresses attached to local NICs
#  |--> Need to update to pull exactly only ips matching RFC1918 CIDRv4's: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
THIS_IPV4_ADDR_PRIVATE=$(ip addr show | grep 'inet' | grep 'scope global' | awk '{ print $2; }' | sed 's/\/.*$//' | grep '\.' | sed -rne 's/^(10|172|192)\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/\0/p';);
echo "THIS_IPV4_ADDR_PRIVATE=[ ${THIS_IPV4_ADDR_PRIVATE} ]";


# ------------------------------------------------------------
#
# Citation(s)
#
#   jodies.de  |  "Networking - IP Subnet Calculator"  |  http://jodies.de/ipcalc
#
# ------------------------------------------------------------