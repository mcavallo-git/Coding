#!/bin/sh
#
# Unifi Devices - Re-adopt to new controller (USG-3P, APs, Switches, etc.)
#   |--> Note: These examples reference a controller at IPv4 "192.168.1.27" --> modify this respectively to match the controller's IPv4 in your environment
# 
# ------------------------------------------------------------
#
# Step 1)
#   SSH into the device you wish to adopt (this guide assumes you have access to such)


# ------------------------------------------------------------
#
# Step 2.1)
#   APs & Switches --> directly call the set-inform command from SSH (sudo may be needed, e.g. sudo set-inform ...)
#
set-inform http://192.168.1.27:8080/inform


#
# Step 2.2)
#   USG-3P (Unifi Security Gateway) Requires you to use the "mca-cli" environment before calling the set-inform command
#
mca-cli
set-inform http://10.0.0.10:8080/inform
exit
reboot


# ------------------------------------------------------------
#
# Step 3.1)
#   Browse to the Unifi controller which will be adoptiong the device(s), and locate the device under "Devices" tab (left)
#
#
# Step 3.2)
#   Select one (single) device, and "Adopt" if available. Otherwise, if the device shows "Managed by another controller" (etc.), click it anyways, and on the right fly-out menu, look for a "+" button --> Click this and select "Adopt" under it
#


# ------------------------------------------------------------
#
# Step 4)
#   You may need to repeat step 2 with another set-inform command to newly-adopted device to complete the handshake, but that should be the last of it!
#


# ------------------------------------------------------------
# Citation(s)
#
#   community.ui.com  |  "USG set-inform for dummies"  |  https://community.ui.com/questions/USG-set-inform-for-dummies/38a7e111-1f0a-4937-bbcd-538ef83e1e49
#
# ------------------------------------------------------------