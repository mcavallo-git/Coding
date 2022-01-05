#!/bin/bash


dhclient -r; dhclient;  # Release the current DHCP lease & pull a new one


#
# Expanded version:
#
if [[ 1 -eq 1 ]]; then
PRIMARY_INET_INTERFACE=$(ifconfig | tr ":" "\n" | head -n 1;);
dhclient -r "${PRIMARY_INET_INTERFACE}";   # Release the current DHCP lease
dhclient "${PRIMARY_INET_INTERFACE}";  # Pull a new DHCP lease
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "ip - use dhcp on eth0 using command line - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/319745
#
#   unix.stackexchange.com  |  "networking - How to release and renew IP address from DHCP on Linux systems? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/405230
#
#   www.cyberciti.biz  |  "Linux Force DHCP Client (dhclient) to Renew IP Address - nixCraft"  |  https://www.cyberciti.biz/faq/howto-linux-renew-dhcp-client-ip-address/
#
# ------------------------------------------------------------