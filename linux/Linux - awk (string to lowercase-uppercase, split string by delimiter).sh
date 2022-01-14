#!/bin/bash
# ------------------------------------------------------------
# Linux - awk (string to lowercase-uppercase)
# ------------------------------------------------------------


# Lowercase
echo "TO_LOWERCASE" | awk '{print tolower($0)}';


# Uppercase
echo "to_uppercase" | awk '{print toupper($0)}';


# ------------------------------
#
# Linux - awk (split string by delimiter)
#

# Get the Nth item in a string/stream split by a given delimiter
THIS_DISK_FREE_BYTES=$(df -B1 . | grep -v 'Use% Mounted on' | awk '{print $4}');
echo -e "\n\n""Free disk space (in bytes) on current disk:  [ ${THIS_DISK_FREE_BYTES} ]""\n\n";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "regex - sed one-liner to convert all uppercase to lowercase? - Stack Overflow"  |  https://stackoverflow.com/a/11638374
#
# ------------------------------------------------------------