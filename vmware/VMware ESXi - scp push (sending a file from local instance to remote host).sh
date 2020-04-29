#!/bin/bash


# Setup public key on local device for incoming SSH authentication
SSH_AS_USERNAME="root";
# > Upload public key to the root directory as "/USERNAME.pub"
mkdir "/etc/ssh/keys-${SSH_AS_USERNAME}"; chmod 0755 "/etc/ssh/keys-${SSH_AS_USERNAME}"; mv "/${SSH_AS_USERNAME}.pub" "/etc/ssh/keys-${SSH_AS_USERNAME}/authorized_keys"; chmod 0600 "/etc/ssh/keys-${SSH_AS_USERNAME}/authorized_keys";


# Connect to external SSH host (using SSH key) & send file(s)
scp -o StrictHostKeyChecking=no -P 22 -i "/PATH/TO/SSH_KEY" "/vmfs/volumes/datastore/VM DIR/VM FILE" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\VM\\ FILE";


