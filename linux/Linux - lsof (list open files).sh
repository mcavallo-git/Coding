#!/bin/sh

# show all files used by network services
sudo lsof -i -P;


# show all files used by network services which contain 'jenkins' anywhere in their lsof output
sudo lsof -i -P | grep -i jenkins;


# ------------------------------------------------------------
# > man lsof
#
#  ...
#       -i [i]   selects the listing of files any of whose Internet address matches the address specified in i.  If no
#                address is specified, this option selects the listing of all Internet and x.25 (HP-UX) network files.
#  ...
#       -P       inhibits the conversion of port numbers to port names for network files.  Inhibiting  the  conversion
#                may make lsof run a little faster.  It is also useful when port name lookup is not working properly.
#  ...
#
# ------------------------------------------------------------