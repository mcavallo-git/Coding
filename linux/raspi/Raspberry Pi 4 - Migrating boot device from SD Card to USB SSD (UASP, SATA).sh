#!/bin/bash
# ------------------------------------------------------------
# Raspberry Pi 4B & 400 - Migrating boot device from SD Card to USB SSD (UASP, SATA)
# ------------------------------------------------------------

# Step 1 - Follow guide @ https://medium.com/xster-tech/move-your-existing-raspberry-pi-4-ubuntu-install-from-sd-card-to-usb-ssd-52e99723f07b


# Step 2 - Update "/etc/fstab" to contain the UUID for "vfat" partition on USB disk
blkid;

cat "/etc/fstab";


# ------------------------------------------------------------
#
# ⚠️ Fallback/Separate guide available @ [Raspberry Pi 4 USB Boot Config Guide for SSD / Flash Drives](https://jamesachambers.com/raspberry-pi-4-usb-boot-config-guide-for-ssd-flash-drives/)
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   jamesachambers.com  |  "Raspberry Pi 4 USB Boot Config Guide for SSD / Flash Drives"  |  https://jamesachambers.com/raspberry-pi-4-usb-boot-config-guide-for-ssd-flash-drives/
#
#   medium.com  |  "Move your existing Raspberry Pi 4 Ubuntu install from SD card to USB/SSD | by xster | xster | Medium"  |  https://medium.com/xster-tech/move-your-existing-raspberry-pi-4-ubuntu-install-from-sd-card-to-usb-ssd-52e99723f07b
#
#   www.youtube.com  |  "How to Boot Raspberry Pi from USB and SSD Drives - YouTube"  |  https://www.youtube.com/watch?v=iHXwHRWTRWM
#
# ------------------------------------------------------------