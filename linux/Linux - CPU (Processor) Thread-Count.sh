#!/bin/bash


lscpu | grep -E '^Thread|^Core|^Socket|^CPU\(';

cat /proc/cpuinfo;

cat /proc/meminfo; # (if you want memory stats)


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "cpu - How to know number of cores of a system in Linux? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/279354
#
# ------------------------------------------------------------