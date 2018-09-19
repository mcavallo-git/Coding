#!/bin/bash

# Linux - find (scripts to perform lookups in linux)
#  |
#  |-->  Note: the argument "-L" is used to dereference symbolic links
#

# Count the number # of files in a given directory 
find -L "/home/user/directory" -type 'f' -name "*" | wc -l; 
# Count-up the total number of [files per file-extension] in a given directory (note: case-insensitive --> a.k.a. it doesn't combine PDF and pdf under the same #)
find -L "/home/user/directory" -type f | sed -e 's/.*\.//' | sed -e 's/.*\///' | sort | uniq -c | sort -rn


# Find paths modified in the last 120 minutes (uses negative 120)
find -L "/home/user/directory" -mmin -120 -ls;
# Find paths modified in the last 2 minutes (uses negative 2)
find -L "/home/user/directory" -mmin -2 -ls;
# Find paths modified in the last 2 days (uses negative 2)
find -L "/home/user/directory" -mtime -2 -ls;
# Find files modified LATER THAN epoch time '1298589405', i.e. since [1970-01-01 00:00:00 + 1298589405s]
find -L "/home/user/directory" -type 'f' -newermt "$(date --date=@1298589405 +'%Y-%m-%d %H:%M:%S')";
# Find files modified NO LATER THAN  epoch time '1298589405', i.e. since [1970-01-01 00:00:00] + [1298589405 seconds]
find -L "/home/user/directory" -type 'f' -not -newermt "$(date --date=@1298589405 +'%Y-%m-%d %H:%M:%S')";

# Show files in a directory (with modified time shown in epoch format & most recent values at the bottom)
ls -aHltr --time-style=+"%s" "/home/user/directory"";
