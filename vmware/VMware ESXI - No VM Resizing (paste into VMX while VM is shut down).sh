#!/bin/sh
# ------------------------------------------------------------
#
# STEP 1: SHUT DOWN TARGET VM
#
# STEP 2: PASTE THE FOLLOWING ITEMS INTO TARGET VM'S "... .vmx" FILE WHILE IT IS SHUT DOWN
#

guestInfo.svga.wddm.modeset=”FALSE”
guestInfo.svga.wddm.modesetCCD=”FALSE”
guestInfo.svga.wddm.modesetLegacySingle=”FALSE”
guestInfo.svga.wddm.modesetLegacyMulti=”FALSE”


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.vgemba.net  |  "VM Console Display Resolution Change - vGemba.net"  |  https://www.vgemba.net/vmware/powercli/VMConsole-Resolution-Change/
#
# ------------------------------------------------------------