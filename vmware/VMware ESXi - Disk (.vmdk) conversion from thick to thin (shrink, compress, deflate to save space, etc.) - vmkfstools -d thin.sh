#!/bin/bash

### NOTE: You must (or at the very least, definitely SHOULD) shut down any machine(s) attached to disks which you intend to copy/resize to OR from

vmkfstools -i /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME.vmdk -d thin /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME-thin.vmdk


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.vmware.com  |  "The vmkfstools Command Options"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.storage.doc/GUID-16D15895-5D91-437A-9304-EBBF4458934B.html
#
#   docs.vmware.com  |  "vmkfstools Command Syntax"  |  https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.storage.doc/GUID-5C413B5E-947E-45B7-90D0-A651863DED18.html
#
# ------------------------------------------------------------