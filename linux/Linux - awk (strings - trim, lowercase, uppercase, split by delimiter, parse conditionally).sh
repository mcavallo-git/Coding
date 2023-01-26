#!/bin/bash
# ------------------------------------------------------------
# Linux - awk (string to lowercase-uppercase, split string by delimiter, parse rows of data conditionally)
# ------------------------------
#
# Lowercase/Uppercase
#

# Lowercase - awk (POSIX compliant)
echo "TO_LOWERCASE" | awk '{print tolower($0)}';

# Uppercase - awk (POSIX compliant)
echo "to_uppercase" | awk '{print toupper($0)}';

# ------------------------------------------------------------
#
# Trim whitespace
#

# Trim any whitespace at the start/end of a string & convert tabs & duplicate-spaces into single space characters
echo "  a  b  c           d  " | awk '{$1=$1;print}';


# ------------------------------------------------------------
#
# Piped strings
#

# Output a piped string
echo "Piped-String" | awk '{print "[ "$0" ] "}';


# ------------------------------
#
# Split by delimiter
#

# Get the Nth item in a string/stream split by a given delimiter
THIS_DISK_FREE_BYTES=$(df -B1 . | grep -v 'Use% Mounted on' | awk '{print $4}');
echo -e "\n\n""Free disk space (in bytes) on current disk:  [ ${THIS_DISK_FREE_BYTES} ]""\n\n";


# ------------------------------
#
# Keep header row (along with whatever else you want to match)
#

# Keep header row && rows whose second column is equal to "b2"
echo -e "col1 col2 col3\na1   a2   a3\nb1   b2   b3\nc1   c2   c3" | awk '($2 == "b2" || NR==1){print}';


# Keep header row && rows whose sixth column is equal to "/"
df -h | awk '($6 == "/" || NR==1){print}';


# ------------------------------
#
# Return only lines whose length is between X and Y total characters
#

# Only return fullpaths in the HOME directory containing between 40 and 50 characters
find "${HOME}/" -type f -exec realpath "{}" \; 2>'/dev/null' | awk '(length >= 40 && length <= 50){print length, $0}' | sort -n -s;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "awk partly string match (if column/word partly matches) - Stack Overflow"  |  https://stackoverflow.com/a/17001897
#
#   stackoverflow.com  |  "How to convert a string to lower case in Bash? - Stack Overflow"  |  https://stackoverflow.com/a/2264537
#
#   stackoverflow.com  |  "regex - sed one-liner to convert all uppercase to lowercase? - Stack Overflow"  |  https://stackoverflow.com/a/11638374
#
#   unix.stackexchange.com  |  "bash - Filter and save in-place, lines with value less than or equal <= X in a specific column and with header - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/392316
#
#   unix.stackexchange.com  |  "shell script - How do I trim leading and trailing whitespace from each line of some output? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/205854
#
# ------------------------------------------------------------