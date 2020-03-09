#!/bin/sh
exit 1;
# ------------------------------------------------------------
#
# Disk.QFullSampleSize - "I/O samples to monitor for detecting non-transient queue full condition. Should be nonzero to enable queue depth throttling."
#  |
#  |--> Can be applied globally, or on a per-device basis
#
Set Disk.QFullSampleSize = 1

# Disk.QFullThreshold - "BUSY or QFULL threshold, upon which LUN queue depth will be throttled. Should be <= QFullSampleSize if throttling is enabled."
#  |
#  |--> Can be applied globally, or on a per-device basis
#
Disk.QFullThreshold = 8;  # Default


# ------------------------------------------------------------
#
# To identify the storage adapter queue depth:
#
#   1. Run the esxtop command in the service console of the ESX host or the ESXi shell 
#       |--> !!! NOTE: in esxtop, pressing "h" will the help menu, including all available options - remember to press "h" if you get lost)
#
#   2. Press "d" to switch display to "d:disk adapter"
#
#   3. Press "f" to add a field, and select the "QSTATS = Queue Stats" field
#
#   4. The value listed in the "AQLEN" column is the queue depth of the storage adapter - This is the maximum number of ESX VMKernel active commands that the  [ ADAPTER DRIVER ]  is configured to support
#
#
# To identify the storage device queue depth:
#
#   1. Run the esxtop command in the service console of the ESX host or the ESXi shell
#
#   2. Press "u" to switch display to "u:disk device"
#
#   3. Press "f" to add a field, and select the "QSTATS = Queue Stats" field
#
#   4. The value listed in the "DQLEN" column is the queue depth of the storage device - This is the maximum number of ESX VMKernel active commands that the  [ DEVICE ]  is configured to support
#
#
#
# Notes:
#
#   The value listed under LQLEN is the LUN queue depth - This is the maximum number of ESX/ESXi VMkernel active commands supported by the LUN
#
#   The value listed under %USD is the percentage of queue depth (adapter, LUN, or world) used by ESX/ESXi VMkernel active commands
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   static.rainfocus.com  |  "vSphere Storage Best Practices - RainFocus"  |  https://static.rainfocus.com/vmware/vmworldeu17/sess/1496368004619001d1ZM/finalpresentationPDF/STO2115BE_EMEA_1507926760000001n4cY.pdf
#
#   kb.vmware.com  |  "Checking the queue depth of the storage adapter and the storage device (1027901)"  |  https://kb.vmware.com/s/article/1027901
#
# ------------------------------------------------------------