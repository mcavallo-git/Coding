#!/bin/bash


esxcli storage core adapter list;  # List all the SCSI Host Bus Adapters on the system.


esxcli storage core claimrule list;  # List all the claimrules on the system.


esxcli storage core device list;  # For devices currently registered with the PSA, list the filters attached to them.


esxcli storage core device stats get;  # List the SCSI stats for SCSI Devices in the system.


esxcli storage core device world list;  # Get a list of the worlds that are currently using devices on the ESX host.


esxcli storage core path list;  # List all the SCSI paths on the system.


esxcli storage filesystem list;  # List the volumes available to the host. This includes VMFS, NAS and VFAT partitions.


esxcli storage filesystem rescan;  # Issue a rescan operation to the VMkernel to have is scan storage devices for new mountable filesystems.


esxcli storage nmp device list;  # List the devices currently controlled by the VMware NMP Multipath Plugin and show the SATP and PSP information associated with that device.


esxcli storage nmp path list;  # List the paths currently claimed by the VMware NMP Multipath Plugin and show the SATP and PSP information associated with that path.


esxcli storage vmfs extent list;  # List the VMFS extents available on the host.


esxcli storage vmfs snapshot list;  # List unresolved snapshots/replicas of VMFS volume.	



# ------------------------------------------------------------
# Citation(s)
#
#   pubs.vmware.com  |  "esxcli storage Commands"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fesxcli_storage.html
#
# ------------------------------------------------------------