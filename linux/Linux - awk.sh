#!/bin/bash

# Use the "awk '{print $X}'" command to get a specific 'column' (per-say) from a given output

THIS_DISK_FREE_BYTES=$(df -B1 . | grep -v 'Use% Mounted on' | awk '{print $4}');
echo -e "\n\n""Free disk space (in bytes) on current disk:  [ ${THIS_DISK_FREE_BYTES} ]""\n\n";
