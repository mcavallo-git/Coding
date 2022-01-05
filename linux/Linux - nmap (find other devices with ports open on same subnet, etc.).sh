#!/bin/bash

# apt-get -y install nmap

# yum -y install nmap

# MongoDB - Show LAN Status (IPv4, Gateway, etc.) & auto-locate other MongoDB devices (with port 27017 open) on same subnet
if [[ 1 -eq 1 ]]; then \
THIS_LAN_SUBNET=$(ip route | grep -v '169.254.0.0/16' | sed -rne "s/^([a-zA-Z0-9]* )*((((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\/([0-9]+)) dev ([a-zA-Z0-9]+) [a-zA-Z0-9 ]* (((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))( [a-zA-Z0-9 ]*)?$/\2/p";); \
THIS_LAN_BROADCAST=$(ip route | grep -v '169.254.0.0/16' | sed -rne "s/^([a-zA-Z0-9]* )*((((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\/([0-9]+)) dev ([a-zA-Z0-9]+) [a-zA-Z0-9 ]* (((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))( [a-zA-Z0-9 ]*)?$/\3/p";); \
THIS_LAN_NETMASK=$(ip route | grep -v '169.254.0.0/16' | sed -rne "s/^([a-zA-Z0-9]* )*((((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\/([0-9]+)) dev ([a-zA-Z0-9]+) [a-zA-Z0-9 ]* (((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))( [a-zA-Z0-9 ]*)?$/\7/p";); \
THIS_LAN_IPV4=$(ip route | grep -v '169.254.0.0/16' | sed -rne "s/^([a-zA-Z0-9]* )*((((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\/([0-9]+)) dev ([a-zA-Z0-9]+) [a-zA-Z0-9 ]* (((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))( [a-zA-Z0-9 ]*)?$/\9/p";); \
THIS_GATEWAY_IPV4=$(ip route | grep 'default via '| sed -rne "s/^([a-zA-Z0-9]* )*default +via +([0-9a-fA-F\:\.]+) +[a-zA-Z0-9]+ +([a-zA-Z0-9]+).+$/\2/p";); \
THIS_LAN_NIC=$(ip route | grep 'default via '| sed -rne "s/^([a-zA-Z0-9]* )*default +via +([0-9a-fA-F\:\.]+) +[a-zA-Z0-9]+ +([a-zA-Z0-9]+).+$/\3/p";); \
test -z "${THIS_LAN_IPV4}" && THIS_LAN_IPV4=$(ip addr show ${THIS_LAN_NIC} | grep 'inet' | grep 'scope global' | awk '{ print $2; }' | sed 's/\/.*$//' | grep '\.' 2>'/dev/null';); \
test -z "${THIS_LAN_NETMASK}" && THIS_LAN_NETMASK=$(ip addr show ${THIS_LAN_NIC} | grep 'inet' | grep 'scope global' | awk '{ print $2; }' | sed 's/^.*\///' 2>'/dev/null';); \
test -z "${THIS_LAN_SUBNET}" && THIS_LAN_SUBNET=$(ip route | grep "$(echo ${THIS_LAN_IPV4} | cut -d. -f1-2)" | sed -rne "s/^([a-zA-Z0-9]* )*((((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\/([0-9]+)) dev ${THIS_LAN_NIC}.*$/\2/p";); \
test -z "${THIS_LAN_BROADCAST}" && THIS_LAN_BROADCAST=$(ip route | grep "$(echo ${THIS_LAN_IPV4} | cut -d. -f1-2)" | sed -rne "s/^([a-zA-Z0-9]* )*((((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\/([0-9]+)) dev ${THIS_LAN_NIC}.*$/\3/p";); \
echo ""; \
echo "THIS_LAN_IPV4 = [ ${THIS_LAN_IPV4} ]"; \
echo "THIS_GATEWAY_IPV4 = [ ${THIS_GATEWAY_IPV4} ]"; \
echo ""; \
echo "THIS_LAN_SUBNET = [ ${THIS_LAN_SUBNET} ]"; \
echo "THIS_LAN_BROADCAST = [ ${THIS_LAN_BROADCAST} ]"; \
echo "THIS_LAN_NETMASK = [ ${THIS_LAN_NETMASK} ]"; \
echo "THIS_LAN_NIC = [ ${THIS_LAN_NIC} ]"; \
echo ""; \
yum -y install nmap; \
echo "Searching for MongoDB Servers on subnet \"${THIS_LAN_SUBNET}\"..."; \
nmap -sV -p 27017 ${THIS_LAN_SUBNET} | sed -rne 's/^Nmap scan report for (.+)$/\1/p'; \
fi;


