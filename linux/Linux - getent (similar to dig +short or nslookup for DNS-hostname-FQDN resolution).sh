#!/bin/bash
# ------------------------------------------------------------


getent ahosts www.google.com | head -n 1 | cut -d' ' -f1;  # Returned [ 20.62.85.184 ]  (dev.sky.softprohq.com DNS A Record)


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "dns - How to test /etc/hosts - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/134144
#
# ------------------------------------------------------------