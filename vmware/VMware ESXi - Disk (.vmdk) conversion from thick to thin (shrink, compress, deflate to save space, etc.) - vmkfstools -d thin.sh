#!/bin/bash

### NOTE: You must (or at the very least, definitely SHOULD) shut down any machine(s) attached to disks which you intend to copy/resize to OR from

vmkfstools -i /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME.vmdk -d thin /vmfs/volumes/datastore1/SERVER_NAME/SERVER_NAME-thin.vmdk
