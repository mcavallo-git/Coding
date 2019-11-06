#!/bin/bash

# df -h --output="source" | grep -v '^Filesystem'

# Slice the top line off-of the output
df -h --output="source" | sed '1!G;h;$!d' | head -n -1 | sed '1!G;h;$!d'; 


# df --output="KEY";  # VAL  (associated column-header)

df -h --output="source";  # "Filesystem
df -h --output="fstype";  # "Type
df -h --output="itotal";  # "Inodes
df -h --output="iused";  # "IUsed
df -h --output="iavail";  # "IFree
df -h --output="ipcent";  # "IUse%
df -h --output="size";  # "Size
df -h --output="used";  # "Used
df -h --output="avail";  # "Avail
df -h --output="pcent";  # "Use%
df -h --output="file";  # "File
df -h --output="target";  # "Mounted on
