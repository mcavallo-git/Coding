#!/bin/bash


# Locate all vmdk files easily parsed from datastores && get each of theirs' dick-usage

find /vmfs/volumes -maxdepth 10 -name "*.vmdk" -type 'f' -size +2147483648


# ------------------------------------------------------------
#
# Citation(s)
#
#   -  |  "-"  |  -
#
# ------------------------------------------------------------