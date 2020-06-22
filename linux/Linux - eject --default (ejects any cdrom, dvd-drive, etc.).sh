#!/bin/bash
# ------------------------------------------------------------
#
# Linux - Eject 
#
# ------------------------------------------------------------
#
# eject
#   -n     With this option the selected device is displayed but no action is performed.
#   -d     If invoked with this option, eject lists the default device name.
#

eject -n;
# eject: device is '/dev/sr0'


# ------------------------------------------------------------
#
# eject 
#   -r, --cdrom     This option specifies that the drive should be ejected using a CDROM eject command.
#

eject -r;


# ------------------------------------------------------------
#
# Citation(s)
#
#   linux.die.net  |  "eject(1): eject removable media - Linux man page"  | https://linux.die.net/man/1/eject
#
#   support.moonpoint.com  |  "Using the eject command on CentOS"  | http://support.moonpoint.com/os/unix/linux/centos/eject.php#:~:text=To%20eject%20a%20CD%2FDVD,eject%20%2D%2Dtrayclose%20or%20%2Dt%20.
#
# ------------------------------------------------------------