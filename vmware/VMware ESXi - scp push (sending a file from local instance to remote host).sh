#!/bin/sh


### NO Rate-Limiting
scp -o StrictHostKeyChecking=no -P 22 "/vmfs/volumes/datastore/VM DIR/VM FILE" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\VM\\ FILE";
scp -o StrictHostKeyChecking=no -P 22 -r "/vmfs/volumes/datastore/VM DIR/" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\";

### WITH Rate-Limiting  - Note that 102,400 Kbps (Kilobit/s) ~= 100 Mbps  (Megabit/s) ~= 12.5 MBps (Megabyte/s)
scp -o StrictHostKeyChecking=no -l 102400 -P 22 "/vmfs/volumes/datastore/VM DIR/VM FILE" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\VM\\ FILE";
scp -o StrictHostKeyChecking=no -l 102400 -P 22 -r "/vmfs/volumes/datastore/VM DIR/" USERNAME@HOSTNAME:"/vmfs/volumes/datastore/VM\\ DIR\\";
