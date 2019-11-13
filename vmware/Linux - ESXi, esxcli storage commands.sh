#!/bin/bash

esxcli storage core adapter list;  # List all the SCSI Host Bus Adapters on the system.

esxcli storage core claimrule list;  # List all the claimrules on the system.

esxcli storage core device list;  # For devices currently registered with the PSA, list the filters attached to them.	

esxcli storage filesystem list;  # Issue a rescan operation to the VMkernel to have is scan storage devices for new mountable filesystems.	

esxcli storage filesystem rescan;  # Issue a rescan operation to the VMkernel to have is scan storage devices for new mountable filesystems.	


# ------------------------------------------------------------
# Citation(s)
#
#   pubs.vmware.com  |  "esxcli storage Commands"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fesxcli_storage.html
#
# ------------------------------------------------------------