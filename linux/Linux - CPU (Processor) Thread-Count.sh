#!/bin/bash


lscpu | grep -E '^Thread|^Core|^Socket|^CPU\(';

cat /proc/cpuinfo;

cat /proc/meminfo; # (if you want memory stats)



#
# Citation(s)
#
#		Thanks to stackexchange user "htaccess" on the forum "https://unix.stackexchange.com/questions/218074"
#
#