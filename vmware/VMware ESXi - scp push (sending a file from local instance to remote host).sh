#!/bin/bash


# Connect to external SSH host (using SSH key) & send file(s)
scp -o StrictHostKeyChecking=no -l 102400 -P 22 -i "/PATH/TO/SSH_KEY" "/vmfs/volumes/datastore/VM DIR/VM FILE" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\VM\\ FILE";

scp -o StrictHostKeyChecking=no -l 102400 -P 22 -i "/PATH/TO/SSH_KEY" -r "/vmfs/volumes/datastore/VM DIR/" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\";

