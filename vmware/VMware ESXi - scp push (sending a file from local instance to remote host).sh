#!/bin/sh
# ------------------------------------------------------------
# VMware ESXi - scp push (send file(s) from local ESXi host to remote ESXi host)
# ------------------------------------------------------------
#
# All-in-one SCP solution
#

if [[ 1 -eq 1 ]]; then
  # Enable ESXi's SSH client (e.g. enable outgoing SSH connections)
  esxcli network firewall ruleset set --ruleset-id sshClient --enabled=true;
  # Send file(s) from local ESXi host to remote ESXi host
  LOCAL_DATASTORE="datastore1";
  DATASTORE_DIRNAME="VM-Directory-Name";
  REMOTE_USER="esxi-user";
  REMOTE_HOST="esxi-hostname";
  REMOTE_DATASTORE="datastore1";
  MAX_BITRATE=512000;  # 512000 kilobytes/sec ~= 62.5 megabytes/sec
  scp -o StrictHostKeyChecking=no -l ${MAX_BITRATE} -P 22 -r "/vmfs/volumes/${LOCAL_DATASTORE}/${DATASTORE_DIRNAME}/" ${REMOTE_USER}@${REMOTE_HOST}:"/vmfs/volumes/${REMOTE_DATASTORE}/${DATASTORE_DIRNAME}/";
fi;


# ------------------------------------------------------------
#
# Step-by-step SCP solution
#

# Enable ESXi's SSH client (e.g. enable outgoing SSH connections)
esxcli network firewall ruleset set --ruleset-id sshClient --enabled=true;


# NO Rate-Limiting
scp -o StrictHostKeyChecking=no -P 22 "/vmfs/volumes/datastore/VM DIR/VM FILE" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\VM\\ FILE";
scp -o StrictHostKeyChecking=no -P 22 -r "/vmfs/volumes/datastore/VM DIR/" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\";


# WITH Rate-Limiting  - Note that 102,400 Kbps (Kilobit/s) ~= 100 Mbps  (Megabit/s) ~= 12.5 MBps (Megabyte/s)
scp -o StrictHostKeyChecking=no -l 102400 -P 22 "/vmfs/volumes/datastore/VM DIR/VM FILE" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\VM\\ FILE";
scp -o StrictHostKeyChecking=no -l 102400 -P 22 -r "/vmfs/volumes/datastore/VM DIR/" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\";


# ------------------------------------------------------------