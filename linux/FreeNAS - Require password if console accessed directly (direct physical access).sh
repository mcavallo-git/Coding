#!/bin/bash
# ------------------------------------------------------------
#
# From a feature-request on domain "redmine.ixsystems.com":
#
# "
#   Current default install enables console menu - which is really useful however it provide root access without any further security checks. Anyone accessing console has root access to server.
#
#   There is option to remove console menu (systems -> advanced) which is the most secure option however this deprives user of console menu unless they know where it is ( /etc/netcli)
#
#   Requirement - Make Console Menu easy to access but require root to authenticate before allowing reconfig/reboot"
#
# "
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   redmine.ixsystems.com  |  "Feature #3500: Improve console security by requiring root password to config FreeNAS - FreeNAS - iXsystems & FreeNAS Redmine"  |  https://redmine.ixsystems.com/issues/3500
#
# ------------------------------------------------------------