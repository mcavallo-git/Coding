#!/bin/sh
#
# ------------------------------------------------------------

### Check datastore reclamation settings
esxcli storage vmfs reclaim config get -l=VMFS_LABEL;
esxcli storage vmfs reclaim config get -u=VMFS_UUID;

### Manually reclaim all space on datastore
esxcli storage vmfs unmap -l=VMFS_LABEL -n=RECLAIM_RATE

### Manually reclaim all space on datastore named "datastore2" at the default rate of "200" units per time-period (NEED MORE DOCS HERE)
esxcli storage vmfs unmap -l=datastore2 -n=200


# ------------------------------------------------------------
# Citation(s)
#
#   docs.vmware.com  |  "vSphere Documentation Center"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vcli.ref.doc_50%2Fesxcli_storage.html
#
#   docs.vmware.com  |  "Configure Space Reclamation for a VMFS6 Datastore"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.storage.doc/GUID-98901BEE-8675-4D39-8AA2-E790EE341986.html
#
#   docs.vmware.com  |  "Verify Configuration for Automatic Space Reclamation"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.storage.doc/GUID-57DAC8D9-C64F-4747-9CE8-14068A073712.html
#
# ------------------------------------------------------------