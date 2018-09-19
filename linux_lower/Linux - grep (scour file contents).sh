#!/bin/bash

#   grep    print lines matching a pattern
#     -r     perform a recursive search
#     -R     perform a recursive search AND follow sym-links
#     -n     get line number where a match was found
#     -w     match whole word only
#     -l     (lower-case L) show the file name, not the result itself
#     -i     ignore case (perform a case-insensitive search)

grep -rnl "/var/lib" -e "saveLog";
grep -rnl "/var/lib" -e "/var/lib/php/session";
grep -rnl "/etc/php.d" -e "max_children";
grep -rnl "/etc/httpd" -e "KeepAlive";
grep -rnl "/etc/nginx" -e "worker_processes";
grep -rnl "/etc/nginx" -e "load_module";
grep -rnl "/usr/local/lib/node_modules/npm" -e "cookie-parser";

TMP_FILE="/root/tmp_files_list"; grep -rnl "/" -e "ip-172-31-30-110" > "${TMP_FILE}"; cat "${TMP_FILE}" | grep -v "Invalid" | grep -v "argument";
grep -rnl "/" --exclude-dir="lxcfs" --regexp="ip-172-31-30-110";
# grep -R --exclude-dir="/var/lib/lxcfs/cgroup" 'some pattern' /path/to/search


# Along with these, --exclude, --include, --exclude-dir or --include-dir flags could be used for efficient searching:
#     This will only search through those files which have .c or .h extensions:
#     grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"
#     This will exclude searching all the files ending with .o extension:
grep --exclude=*.o -rnw '/path/to/somewhere/' -e "pattern"

# Just like exclude files, it's possible to exclude/include directories through --exclude-dir and --include-dir parameter. For example, this will exclude the dirs dir1/, dir2/ and all of them matching *.dst/:
grep --exclude-dir={dir1,dir2,*.dst} -rnw '/path/to/somewhere/' -e "pattern"

# This works very well for me, to achieve almost the same purpose like yours.

# For more options check man grep.

                                                      #  Thanks to rakib_ from StackOverflow
																											      # http://stackoverflow.com/questions/16956810/how-to-find-all-files-containing-specific-text-on-linux