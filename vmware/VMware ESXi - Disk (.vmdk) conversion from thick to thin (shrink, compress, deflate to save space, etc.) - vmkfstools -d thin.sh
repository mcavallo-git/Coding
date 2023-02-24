#!/bin/sh

### NOTE: You must shut down any virrtual machine(s) attached to disks which you intend to copy/resize to OR from

# ------------------------------------------------------------
#
# Stop any VMs whose disks will be converted from thin to thick
#  > In ESXi's "Datastore Browser" (in the Web GUI under "Storage" on the left), locate the ".vmdk" file to convert from thin to thick provisioning
#   > Right-click the ".vmdk" file to convert and select the "Inflate" option - This will begin converting the disk from thin to thick
#    > If any errors are thrown, the below approach using "vmkfstools" should still work to convert disks from thin to thick provisioning
#
# ------------------------------------------------------------

### Thin to Thick
vmkfstools -i /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME.vmdk -d zeroedthick /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME-thick.vmdk

### Thick to Thin
vmkfstools -i /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME.vmdk -d thin /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME-thin.vmdk

# ------------------------------------------------------------

### Thin to Thick - BACKGROUND JOB (allows ssh tunnel interruption/disconnection while it continues to process in the background)
nohup vmkfstools -i /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME.vmdk -d zeroedthick /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME-thick.vmdk > "/tmp/vmkfstools_$(date +'%Y%m%d%H%M%S').log" 2>&1 &

### Thick to Thin - BACKGROUND JOB (allows ssh tunnel interruption/disconnection while it continues to process in the background)
nohup vmkfstools -i /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME.vmdk -d thin /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME-thin.vmdk > "/tmp/vmkfstools_$(date +'%Y%m%d%H%M%S').log" 2>&1 &

### Watch the background job's log
while [ 1 ]; do clear; date; echo -e "\n\n"; cat /tmp/vmkfstools_$(date +'%Y%m%d')*.log; echo -e "\n\n"; df -h; sleep 5; done;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.vmware.com  |  "The vmkfstools Command Options"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.storage.doc/GUID-16D15895-5D91-437A-9304-EBBF4458934B.html
#
#   docs.vmware.com  |  "vmkfstools Command Syntax"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.storage.doc/GUID-5C413B5E-947E-45B7-90D0-A651863DED18.html
#
# ------------------------------------------------------------