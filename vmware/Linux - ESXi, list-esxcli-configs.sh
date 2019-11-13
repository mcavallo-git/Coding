#!/bin/bash
#
# ROOT_CMD="/root/list-esxcli-configs.sh" && echo "" > "${ROOT_CMD}" && vi "${ROOT_CMD}" && chmod 0700 "${ROOT_CMD}";
#
# ------------------------------------------------------------

DIR_CHOWN="root:root";

DIR_PATH="/root"; mkdir -p "${DIR_PATH}"; chmod 0700 "${DIR_PATH}"; chown "${DIR_CHOWN}" "${DIR_PATH}";

DIR_PATH="/root/esxcli"; mkdir -p "${DIR_PATH}"; chmod 0700 "${DIR_PATH}"; chown "${DIR_CHOWN}" "${DIR_PATH}";

# ------------------------------------------------------------

esxcli storage core adapter list > /root/esxcli/esxcli-storage-core-adapter-list.log;

esxcli storage core claimrule list > /root/esxcli/esxcli-storage-core-claimrule-list.log;

esxcli storage core device list > /root/esxcli/esxcli-storage-core-device-list.log;

esxcli storage core device stats get > /root/esxcli/esxcli-storage-core-device-stats-get.log;

esxcli storage core device world list > /root/esxcli/esxcli-storage-core-device-world-list.log;

esxcli storage core path list > /root/esxcli/esxcli-storage-core-path-list.log;

esxcli storage filesystem list > /root/esxcli/esxcli-storage-filesystem-list.log

esxcli storage nmp device list > /root/esxcli/esxcli-storage-nmp-device-list.log;

esxcli storage nmp path list > /root/esxcli/esxcli-storage-nmp-path-list.log;

esxcli storage vmfs extent list > /root/esxcli/esxcli-storage-vmfs-extent-list.log;

esxcli storage vmfs snapshot list > /root/esxcli/esxcli-storage-vmfs-snapshot-list.log;

# ------------------------------------------------------------

find "/root/esxcli" -type f -print0 | xargs -0 chmod 0600;

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