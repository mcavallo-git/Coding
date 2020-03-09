#!/bin/sh
exit 1;
# ------------------------------------------------------------
#
# Get a list of ALL currently enabled/active modules, then grab ALL of their parameters at once
#
esxcli system module list --loaded 1 --enabled 1 | grep -v '^------' | grep -v '^Name ' | awk '{print $1}' | sort | while read EachModuleName; do
echo "Calling  [ esxcli system module parameters list -m ${EachModuleName}; ]  ...";
esxcli system module parameters list -m ${EachModuleName};
done;


# ------------------------------------------------------------
#
# Citation(s)
#
#   support.purestorage.com  |  "How To: Adjusting the UCS nfnic queue depth on ESXi 6.7 - Pure1 Support Portal"  |  https://support.purestorage.com/Solutions/VMware_Platform_Guide/003Virtual_Volumes_-_VVols/How_To%3A_Adjusting_the_UCS_nfnic_queue_depth_on_ESXi_6.7
#
# ------------------------------------------------------------