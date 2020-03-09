#!/bin/sh
exit 1;
# ------------------------------------------------------------


### To identify the storage adapter queue depth:
1. Run the esxtop command in the service console of the ESX host or the ESXi shell (!!!NOTE: in esxtop, pressing "h" will the help menu, including all available options - remember to press "h" if you get lost)
2. Press "d" to switch display to "d:disk adapter"
3. Press "f" to add a field, and select the "QSTATS = Queue Stats" field
4. The value listed in the "AQLEN" column is the queue depth of the storage adapter - This is the maximum number of ESX VMKernel active commands that the  [ ADAPTER DRIVER ]  is configured to support


### To identify the storage device queue depth:
1. Run the esxtop command in the service console of the ESX host or the ESXi shell
2. Press "u" to switch display to "u:disk device"
3. Press "f" to add a field, and select the "QSTATS = Queue Stats" field
4. The value listed under DQLEN is the queue depth of the storage device. This is the maximum number of ESX VMKernel active commands that the device is configured to support.
4. The value listed in the "DQLEN" column is the queue depth of the storage device - This is the maximum number of ESX VMKernel active commands that the  [ DEVICE ]  is configured to support


### Notes:

The value listed under LQLEN is the LUN queue depth - This is the maximum number of ESX/ESXi VMkernel active commands supported by the LUN

The value listed under %USD is the percentage of queue depth (adapter, LUN, or world) used by ESX/ESXi VMkernel active commands



# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Checking the queue depth of the storage adapter and the storage device (1027901)"  |  https://kb.vmware.com/s/article/1027901
#
# ------------------------------------------------------------