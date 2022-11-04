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


# ------------------------------
#
# Linux - awk (keep header along with whatever else you want to match)
#

# Keep header row && rows whose second column is equal to "b2"
echo -e "col1 col2 col3\na1   a2   a3\nb1   b2   b3\nc1   c2   c3" | awk '($2 == "b2" || NR==1){print}';


# Keep header row && rows whose sixth column is equal to "/"
df -h | awk '($6 == "/" || NR==1){print}';


# ------------------------------
#
# Linux - awk (only return lines containing greater than X characters but less than Y characters)
#

# Only return fullpaths in the HOME directory containing between 40 and 50 characters
find "${HOME}/" -type f -exec realpath "{}" \; 2>'/dev/null' | awk '(length >= 40 && length <= 50){print length, $0}' | sort -n -s;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "awk partly string match (if column/word partly matches) - Stack Overflow"  |  https://stackoverflow.com/a/17001897
#
#   stackoverflow.com  |  "regex - sed one-liner to convert all uppercase to lowercase? - Stack Overflow"  |  https://stackoverflow.com/a/11638374
#
#   unix.stackexchange.com  |  "bash - Filter and save in-place, lines with value less than or equal <= X in a specific column and with header - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/392316
#
# ------------------------------------------------------------