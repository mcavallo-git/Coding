#!/bin/sh
# ------------------------------------------------------------

# List Datastores
esxcli storage filesystem list | grep -v '^\(-----\|Mount\)' | grep -v '\s\s\(BOOTBANK\|LOCKER\)';

# Count Datastores
DATASTORE_COUNT="$(esxcli storage filesystem list | grep -v '^\(-----\|Mount\)' | grep -v '\s\s\(BOOTBANK\|LOCKER\)' | wc -l;)"; echo -e "\n""DATASTORE_COUNT = [ ${DATASTORE_COUNT} ]""\n";


# ------------------------------------------------------------

# Check datastore reclamation settings
esxcli storage vmfs reclaim config get -l=VMFS_LABEL;
esxcli storage vmfs reclaim config get -u=VMFS_UUID;

# Manually reclaim all space on datastore
esxcli storage vmfs unmap -l=VMFS_LABEL -n=RECLAIM_RATE

# Run the same job as above as a background job
nohup esxcli storage vmfs unmap -l=VMFS_LABEL > "/tmp/vmfs_unmap_$(date +'%Y%m%d%H%M%S').log" 2>&1 &


# ------------------------------------------------------------

# Manually reclaim all space on datastore named "datastore2"
esxcli storage vmfs unmap -l=datastore2

# Run the same job as above w/o the units declaration and as a background job
nohup esxcli storage vmfs unmap -l=datastore2 > "/tmp/vmfs_unmap_$(date +'%Y%m%d%H%M%S').log" 2>&1 &

# Watch the background job's log
while [ 1 ]; do clear; date; echo -e "\n\n"; df -h; echo -e "\n\n"; cat /tmp/vmfs_unmap_$(date +'%Y%m%d')*.log; sleep 2; done;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.vmware.com  |  "vSphere Documentation Center"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fesxcli_storage.html
#
#   docs.vmware.com  |  "Configure Space Reclamation for a VMFS6 Datastore"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.storage.doc/GUID-98901BEE-8675-4D39-8AA2-E790EE341986.html
#
#   docs.vmware.com  |  "Verify Configuration for Automatic Space Reclamation"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.storage.doc/GUID-57DAC8D9-C64F-4747-9CE8-14068A073712.html
#
# ------------------------------------------------------------