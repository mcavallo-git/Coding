#!/bin/sh
#
# ROOT_CMD="/root/list-esxcli-configs.sh" && echo "" > "${ROOT_CMD}" && vi "${ROOT_CMD}" && chmod 0700 "${ROOT_CMD}";
#
# ------------------------------------------------------------

DIR_CHOWN="root:root";

DIR_PATH="/root"; mkdir -p "${DIR_PATH}"; chmod 0700 "${DIR_PATH}"; chown "${DIR_CHOWN}" "${DIR_PATH}";

DIR_PATH="/root/esxcli"; mkdir -p "${DIR_PATH}"; chmod 0700 "${DIR_PATH}"; chown "${DIR_CHOWN}" "${DIR_PATH}";


# ------------------------------------------------------------

esxcli storage core adapter list > /root/esxcli/esxcli-storage-core-adapter-list.log;  # List all the SCSI Host Bus Adapters on the system.


esxcli storage core claimrule list > /root/esxcli/esxcli-storage-core-claimrule-list.log;  # List all the claimrules on the system.


esxcli storage core device list > /root/esxcli/esxcli-storage-core-device-list.log;  # For devices currently registered with the PSA, list the filters attached to them.


esxcli storage core device stats get > /root/esxcli/esxcli-storage-core-device-stats-get.log;  # List the SCSI stats for SCSI Devices in the system.


esxcli storage core device world list > /root/esxcli/esxcli-storage-core-device-world-list.log;  # Get a list of the worlds that are currently using devices on the ESX host.


esxcli storage core path list > /root/esxcli/esxcli-storage-core-path-list.log;  # List all the SCSI paths on the system.


esxcli storage filesystem list > /root/esxcli/esxcli-storage-filesystem-list.log  # List the volumes available to the host. This includes VMFS, NAS and VFAT partitions.


esxcli storage nmp device list > /root/esxcli/esxcli-storage-nmp-device-list.log;  # List the devices currently controlled by the VMware NMP Multipath Plugin and show the SATP and PSP information associated with that device.


esxcli storage nmp path list > /root/esxcli/esxcli-storage-nmp-path-list.log;  # List the paths currently claimed by the VMware NMP Multipath Plugin and show the SATP and PSP information associated with that path.


esxcli storage vmfs extent list > /root/esxcli/esxcli-storage-vmfs-extent-list.log;  # List the VMFS extents available on the host.


esxcli storage vmfs snapshot list > /root/esxcli/esxcli-storage-vmfs-snapshot-list.log;# List unresolved snapshots/replicas of VMFS volume.


# ------------------------------------------------------------

find "/root/esxcli" -type f -print0 | xargs -0 chmod 0600;

exit 0;


# ------------------------------------------------------------

esxcli storage filesystem rescan;  # Issue a rescan operation to the VMkernel to have is scan storage devices for new mountable filesystems.


# ------------------------------------------------------------
# Citation(s)
#
#   pubs.vmware.com  |  "vSphere Command-Line Interface Reference"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fvcli-right.html
#
#   pubs.vmware.com  |  "esxcli storage Commands"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fesxcli_storage.html
#
#   pubs.vmware.com  |  "esxcli system Commands"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fesxcli_system.html
#
# ------------------------------------------------------------