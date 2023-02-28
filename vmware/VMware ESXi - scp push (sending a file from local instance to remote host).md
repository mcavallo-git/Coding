<!-- ------------------------------------------------------------ -->

***
# ESXi > SCP (Secure Copy) a directory or VM from one ESXi host to another
  1. On the source ESXi host, stop & unregister the VM which will be transferred/copied
  2. Run the following via SSH on the *source* ESXi host:
  ```bash
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
  ```
  3. Once the transfer has completed, register the VM on the destination ESXi host

<!-- ------------------------------------------------------------ -->

***

# ESXi SCP - Breakdown of steps

- ### Enable ESXi's SSH client (e.g. enable outgoing SSH connections)
  ```bash
  esxcli network firewall ruleset set --ruleset-id sshClient --enabled=true;
  ```

- ### SCP (Secure Copy) a single file
  - ###### NO Rate-Limiting
    ```bash
    scp -o StrictHostKeyChecking=no -P 22 "/vmfs/volumes/datastore/VM DIR/VM FILE" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\VM\\ FILE";
    ```
  - ###### WITH Rate-Limiting
    ```bash
    # Note: 512000 kilobytes/sec ~= 62.50 megabytes/sec
    scp -o StrictHostKeyChecking=no -l 512000 -P 22 "/vmfs/volumes/datastore/VM DIR/VM FILE" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\VM\\ FILE";
    ```

- ### SCP (Secure Copy) an entire directory (or VM directory)
  - ###### NO Rate-Limiting
    ```bash
    scp -o StrictHostKeyChecking=no -P 22 -r "/vmfs/volumes/datastore/VM DIR/" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\";
    ```
  - ###### WITH Rate-Limiting
    ```bash
    # Note: 512000 kilobytes/sec ~= 62.50 megabytes/sec
    scp -o StrictHostKeyChecking=no -l 512000 -P 22 -r "/vmfs/volumes/datastore/VM DIR/" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\";
    ```


# ------------------------------------------------------------