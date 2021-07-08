#!/bin/bash
# ------------------------------------------------------------
# UniFi - Update Firmware on UCK-G2 (UniFi Cloud Key Gen 2)
# ------------------------------------------------------------
#
# Step 1/2 - Get URL for latest firmware version from Ubiquiti's Downloads portal at:
#
#    https://www.ui.com/download/unifi/unifi-cloud-key-gen2
#
# ------------------------------------------------------------
#
# Step 2/2 - SSH into target [ UniFi Cloud Key Gen 2 ] & run the following command (replacing URL with the updated URL from step 1):
#

FIRMWARE_URL="https://fw-download.ubnt.com/data/unifi-cloudkey/e9cc-UCKG2-2.1.11-1cf4bd8262b64919ac100cc5b69dc0b1.bin";
ubnt-systool fwupdate "${FIRMWARE_URL}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.ui.com  |  "Ubiquiti - Downloads"  |  https://www.ui.com/download/unifi/unifi-cloud-key-gen2
#
#   help.ui.com  |  "UniFi - UDM/UCK: How to Change the UniFi Network Version Using SSH – Ubiquiti Support and Help Center"  |  https://help.ui.com/hc/en-us/articles/216655518-UniFi-UDM-UCK-How-to-Change-the-Controller-Version-Using-SSH-
#
# ------------------------------------------------------------