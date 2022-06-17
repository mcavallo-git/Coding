#!/bin/bash
# ------------------------------------------------------------
#
# Linux - grep (print lines matching a pattern, scour file contents)
#
#   iportant grep cli options (taken from "man grep"):
#        -r     perform a recursive search
#        -R     perform a recursive search AND follow sym-links
#        -n     get line number where a match was found
#        -l     (lower-case L) show the file name, not the result itself
#        -w     match whole word only
#        -i     ignore case (perform a case-insensitive search)
#        -v     invert the sense of matching, to select non-matching lines.
#
# ------------------------------------------------------------
#
# Example) Removing empty lines (e.g. remove lines containing only whitespace)
#

EXAMPLE_REMOVE_EMPTY_LINES="Line 01"$'\n'$'\n'$'\n'"Line 04"$'\n'$'\n'$'\n'"Line 07\n\n\nLine 10";
echo "Example)- Before removing empty lines:"; echo -e "${EXAMPLE_REMOVE_EMPTY_LINES}";
echo "Method 1 - After removing empty lines:"; echo -e "${EXAMPLE_REMOVE_EMPTY_LINES}" | grep '\S'; # Method 1.1.1 - Remove lines containing only whitespace characters (spaces/tabs)
echo "Method A - After removing empty lines:"; echo -e "${EXAMPLE_REMOVE_EMPTY_LINES}" | grep '^$'; # Method 1.1.2 - Keep lines with at least 1 whitespace (space/tab) character


# ------------------------------------------------------------
#
# Example) grep + regex (must use backslashes for special regex chars) - Find lines which do NOT contain any of a given set of strings
#

echo "Do not match" | grep -v "\(Don't match\)\|\(Do not match\)";  # Returns ""
echo "Don't match"  | grep -v "\(Don't match\)\|\(Do not match\)";  # Returns ""
echo "Do match"     | grep -v "\(Don't match\)\|\(Do not match\)";  # Returns "Do match"


# ------------------------------------------------------------
#
#   grep    print lines matching a pattern
#    ...
#      options
#        -r     perform a recursive search
#        -R     perform a recursive search AND follow sym-links
#        -n     get line number where a match was found
#        -l     (lower-case L) show the file name, not the result itself
#        -w     match whole word only
#        -i     ignore case (perform a case-insensitive search)
#        -v     invert the sense of matching, to select non-matching lines.
#
# ------------------------------------------------------------
#
# Example) Search syslogs for crontab edits
#

grep -rn /var/log/syslog* --regexp='crontab' | sort --numeric-sort;


# ------------------------------------------------------------
#
# Example) Search [docker ps] to count the number of containers running
#

docker_instances_running=$(sudo docker ps --all | grep -c  '\<Up .* hours\>'); echo "docker_instances_running: ${docker_instances_running}";


# ------------------------------------------------------------

grep -rnl "/var/lib" -e "saveLog";
grep -rnl "/var/lib" -e "/var/lib/php/session";
grep -rnl "/etc/php.d" -e "max_children";
grep -rnl "/etc/httpd" -e "KeepAlive";
grep -rnl "/etc/nginx" -e "worker_processes";
grep -rnl "/etc/nginx" -e "load_module";
grep -rnl "/usr/local/lib/node_modules/npm" -e "cookie-parser";
grep -rnl "/var/lib/jenkins" -e "progress-bar-striped";
grep -rnl "/var/cache/jenkins" -e "_yuiResizeMonitor";

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



# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How do I find all files containing specific text on Linux? - Stack Overflow"  |  https://stackoverflow.com/a/16957078
#
#   www.gnu.org  |  "The Backslash Character and Special Expressions (GNU Grep 3.4)"  |  https://www.gnu.org/software/grep/manual/html_node/The-Backslash-Character-and-Special-Expressions.html
#
# ------------------------------------------------------------