#!/bin/bash
# ------------------------------------------------------------
#  Linux - hdparm -Tt (disk benchmarking tool - test read speeds (no write test))
# ------------------------------------------------------------
#
# hdparm
#        -t     Perform timings of device reads for benchmark and comparison purposes
#        -T     Perform timings of cache reads for benchmark and comparison purposes
#
# ------------------------------------------------------------

# Ex) Benchmark read speeds of the topmost disk returned by lsblk

DISK_PATH=$(lsblk | grep disk | awk '{print $1}' | head -n 1;); hdparm -Tt "/dev/${DISK_PATH}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   askubuntu.com  |  "How to check hard disk performance - Ask Ubuntu"  |  https://askubuntu.com/a/87036
#
# ------------------------------------------------------------