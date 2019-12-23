#!/bin/bash

nmcli d; # --> Locate the disabled connection's name

nmtui; # --> Enable the only available connection

# Done!

# ------------------------------------------------------------
#
# Citation(s)
#
#   lintut.com  |  "How to setup network after RHEL/CentOS 7 minimal installation"  |  https://lintut.com/how-to-setup-network-after-rhelcentos-7-minimal-installation/
#
# ------------------------------------------------------------