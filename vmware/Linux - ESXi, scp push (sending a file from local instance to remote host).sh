#!/bin/bash


scp -o StrictHostKeyChecking=no -P 22 -i "/PATH/TO/SSH_KEY" "/vmfs/volumes/datastore/VM DIR/VM FILE" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\VM\\ FILE"

