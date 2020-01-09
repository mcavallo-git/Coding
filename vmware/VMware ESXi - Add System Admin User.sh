#!/bin/sh
#
# ------------------------------------------------------------

USER_NAME="DAT_USER";

USER_PASS="DAT_PASS";

esxcli system account add --id "${USER_NAME}" --password "${USER_PASS}";

esxcli system permission set --id "${UID}" --role "Admin";

esxcli system account list;

esxcli system permission list;


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