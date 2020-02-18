#!/bin/bash

### NOTE: You must (or at the very least, definitely SHOULD) shut down any machine(s) attached to disks which you intend to copy/resize to OR from

### Thick to Thin
vmkfstools -i /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME.vmdk -d thin /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME-thin.vmdk

### Thin to Thick
vmkfstools -i /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME.vmdk -d zeroedthick /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME-thick.vmdk

# ------------------------------------------------------------

### Run the disk-conversion job as a background job (optional - allows you to disconnect and it continues to process in the background)
nohup vmkfstools -i /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME.vmdk -d thin /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME-thin.vmdk > "/tmp/vmkfstools_$(date +'%Y%m%d%H%M%S').log" 2>&1 &

### Watch the background job's log
while [ 1 ]; do clear; date; echo -e "\n\n"; df -h; echo -e "\n\n"; cat /tmp/vmkfstools_$(date +'%Y%m%d')*.log; sleep 2; done;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.vmware.com  |  "The vmkfstools Command Options"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.storage.doc/GUID-16D15895-5D91-437A-9304-EBBF4458934B.html
#
#   docs.vmware.com  |  "vmkfstools Command Syntax"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.storage.doc/GUID-5C413B5E-947E-45B7-90D0-A651863DED18.html
#
# ------------------------------------------------------------