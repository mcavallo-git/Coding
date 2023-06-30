#!/bin/bash
# ------------------------------------------------------------

getent ahosts "www.google.com" | head -n 1 | cut -d' ' -f1;  # Gets DNS A Record

getent group "www-data";  # Gets the users in a group


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "dns - How to test /etc/hosts - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/134144
#
# ------------------------------------------------------------