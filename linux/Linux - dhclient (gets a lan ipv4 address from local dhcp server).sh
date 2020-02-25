#!/bin/bash

dhclient $(ifconfig tr ":" "\n" | head -n 1;);


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "ip - use dhcp on eth0 using command line - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/319745
#
# ------------------------------------------------------------