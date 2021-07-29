#!/bin/sh
#
# VMware ESXi - formatwithmbr (Shift + O boot option when formatting ESXi OS onto disk, avoids UEFI partitioning & uses MBR)
#
# ------------------------------------------------------------


When the ESXi boot media is first loaded (and before it begins loading files from boot disk), there should be an option at the bottom left of the screen similar to:
"SHIFT+O : Edit Boot Options"


Press [ Shift + O ] (letter "O", not number "0"), and a terminal should appear at the bottom of the screen with either of the following:
"runweasel"
or
"runweasel cdromBoot"


Either way, add one space, then the command "formatwithmbr" after the existing line of text, to end up with either:
"runweasel formatwithmbr"
or
"runweasel cdromBoot formatwithmbr"


This should cause the ESXi boot media to format the ESXi OS using MBR paritioning instead of UEFI


# ------------------------------------------------------------
#
#  Citation(s)

#   datareload.com  |  "Getting vSphere 6.7U3b up and running on a non-UEFI server | Datareload"  |  https://datareload.com/getting-vsphere-6-7u3b-up-and-running-on-a-non-uefi-server/
#
# ------------------------------------------------------------