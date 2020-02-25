#!/bin/bash

# If you're running vt a.k.a. newcons, try:

kbdcontrol -b quiet.off


# If that works, you can make it permanent in your /etc/rc.conf:

allscreens_kbdflags="-b quiet.off"


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "audio - How do I disable the system beep in FreeBSD 10.1? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/219826
#
# ------------------------------------------------------------