#!/bin/sh


# Locate all vmdk files easily parsed from datastores && get each of theirs' dick-usage

find /vmfs/volumes/ -maxdepth 3 -name "*" -type 'f' -size +2097152 | while IFS= read -r EachVMDisk; do du -sh "${EachVMDisk}"; done;

# ------------------------------------------------------------
#
# Citation(s)
#
#   -  |  "-"  |  -
#
# ------------------------------------------------------------