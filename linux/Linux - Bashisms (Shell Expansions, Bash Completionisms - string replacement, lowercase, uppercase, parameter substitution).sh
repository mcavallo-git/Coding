#!/bin/bash
# ------------------------------------------------------------
#
#	Linux - Shell Expansions (e.g. "Bashisms" or "Bash Completionisms")  -  https://www.gnu.org/software/bash/manual/html_node/#toc-Shell-Expansions-1
#
# ------------------------------------------------------------
#
# Count the # of characters in a string (e.g. Get the length of a string as an integer value)
#

parameter="12345"; echo "${#parameter}";
###  Outputs "5"

parameter="1234567890"; echo "${#parameter}";
###  Outputs "10"

# ------------------------------------------------------------
#
# Shell Parameter Expansion (e.g. "Substring Expansion")  -  https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
#

# General Syntax (two options)
${parameter:offset}
${parameter:offset:length}


# ------------------------------
#
#  Substring Expansion (Option 1)  (Left Trim/Slice)  -  https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
#
#  Syntax:   ${parameter:offset}
#

# Example(s)
parameter="1234567890"; offset=3;  echo "${parameter:offset}";    # Parameter Expansion  - Returns "4567890"  -  Slices leftmost ${offset} chars
parameter="1234567890"; offset=3;  echo "${parameter: -offset}";  # Parameter Expansion  - Returns "890"  -  Returns rightmost ${offset} chars
parameter="1234567890"; offset=3;  echo "${parameter:-offset}";   # Parameter Substitution - Returns "1234567890"


# ------------------------------
#
#  Substring Expansion (Option 2)  (Substr, including Right Trim/Slice)  -  https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
#
#  Syntax:   ${parameter:offset:length}
#

# Example(s)
parameter="1234567890"; offset=0;  length=3; echo "${parameter:offset:length}";    # Returns "123"      -  Starts at pos 0, goes 3 chars
parameter="1234567890"; offset=0;  length=3; echo "${parameter:offset: -length}";  # Returns "1234567"  -  Starts at pos 0, goes til 3 chars til end


parameter="1234567890"; offset=2;  length=2; echo "${parameter:offset:length}";    # Returns "34"  -  Starts at pos 2, goes 2 chars
parameter="1234567890"; offset=2;  length=2; echo "${parameter:offset: -length}";  # Returns "345678"  -  Starts at pos 2, goes til 2 chars til end


parameter="1234567890"; offset=-6; length=2; echo "${parameter:offset:length}";    # Returns "56"  -  Starts at pos 6 til end, goes 2 chars
parameter="1234567890"; offset=-6; length=2; echo "${parameter:offset: -length}";  # Returns "5678"  -  Starts at pos 6 til end, goes til 2 chars til end
parameter="1234567890"; offset=-6; length=1; echo "${parameter:offset: -length}";  # Returns "56789"  -  Starts at pos 6 til end, goes til 1 char til end

parameter="1234567890"; offset=4;  length=4; echo "${parameter:offset: -length}";  # Returns "56"  -  Starts at pos 4, goes til 4 chars til end
parameter="1234567890"; offset=4;  length=5; echo "${parameter:offset: -length}";  # Returns "5"   -  Starts at pos 4, goes til 5 chars til end
parameter="1234567890"; offset=4;  length=6; echo "${parameter:offset: -length}";  # Returns ""    -  Starts at pos 4, goes til 6 chars til end


# ------------------------------------------------------------
#
# Substring Replacement
#
#   SYNTAX:   ${parameter//STRING_TO_FIND/STRING_TO_REPLACE_WITH}
#             ${HAYSTACK//${NEEDLE}/${REPLACEMENT}}   <-- using nested variables
#

# Bash Substring Replacement Exaxmple: Replace dashes with underscores
parameter="Bash Substring Replacement - Replace-Dashes-With-Underscores";
MODIFIED_STRING="${parameter//-/_}";
echo -e "\nEXAMPLE_STRING=\"${parameter}\"\nMODIFIED_STRING=\"${MODIFIED_STRING}\"\m";


# Bash Substring Replacement Exaxmple: Escape spaces with backslashes
parameter="Bash Substring Replacement - Escape spaces with backslashes";
MODIFIED_STRING="${parameter// /\\ }";
echo -e "\nEXAMPLE_STRING=\"${parameter}\"\nMODIFIED_STRING=\"${MODIFIED_STRING}\"\m";


# Bash Substring Replacement Example:  Modular Example inteded for copying/pasting into other script(s)
HAYSTACK="this example, that example";
NEEDLE="th";
REPLACEMENT="d";
MODIFIED_STRING="${HAYSTACK//${NEEDLE}/${REPLACEMENT}}" && echo "${MODIFIED_STRING}";


# Bash Substring Replacement Example:  Slice one static substring out of another string
HAYSTACK="/var/log/long/filepath";
SLICE_OUT="/var/log/";
REMAINDER="${HAYSTACK//${SLICE_OUT//\//\\\/}/}";
echo "HAYSTACK:   [ ${HAYSTACK} ]"; \
echo "SLICE_OUT:  [ ${SLICE_OUT} ]"; \
echo "REMAINDER:  [ ${REMAINDER} ]";


# ------------------------------------------------------------
#
### String variable to-Lowercase  -->  https://stackoverflow.com/a/2264537
#

#
# POSIX compliant approach(es):
#
#  (awk) SYNTAX:  echo "$a" | awk '{print tolower($0)}';
parameter="Dat-Example-Doe" && echo "${parameter}" | awk '{print tolower($0)}';
#
#  (tr) SYNTAX:  echo "$a" | tr '[:upper:]' '[:lower:]';
parameter="Dat-Example-Doe" && echo "${parameter}" | tr '[:upper:]' '[:lower:]';


#
# Non-POSIX compliant approach(es):
#
#  (bashism) SYNTAX:   ${parameter,,}
parameter="Dat-Example-Doe" && echo "${parameter,,}";  # Bashism requiring Bash v4.0+


# ------------------------------------------------------------
#
### String variable to-Uppercase
#
#   SYNTAX:   ${parameter^^}
#

parameter="Dat-Example-Doe" && echo "${parameter^^}";


# ------------------------------------------------------------
#
### Parameter Substitution - If main variable referenced is empty/unset, will fall back to a separate value (specified with a ":-" separator within the "${}" variable block directly after the variable name)
#

echo "${VAR_NOT_SET:-55}";

# Can fallback to another parameter
DEFAULT_VAL="55" && echo "${VAR_NOT_SET:-${DEFAULT_VAL}}";

# Can be nested
echo "${VAR_NOT_SET:-${VAR_ALSO_NOT_SET:-72}}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   betterprogramming.pub  |  "24 Bashism To Avoid for POSIX-Compliant Shell Scripts | by Shinichi Okada | Aug, 2021 | Better Programming"  |  https://betterprogramming.pub/24-bashism-to-avoid-for-posix-compliant-shell-scripts-8e7c09e0f49a
#
#   stackoverflow.com  |  "Case insensitive comparison of strings in shell script"  |  https://stackoverflow.com/a/19411918
#
#   stackoverflow.com  |  "How to convert a string to lower case in Bash? - Stack Overflow"  |  https://stackoverflow.com/a/2264537
#
#   stackoverflow.com  |  "Remove first character of a string in Bash - Stack Overflow"  |  https://stackoverflow.com/a/46699430
#
#   tldp.org  |  "Manipulating Strings"  |  https://tldp.org/LDP/abs/html/string-manipulation.html
#
#   unix.stackexchange.com  |  "How to input / start a new line in bash terminal?"  |  https://unix.stackexchange.com/a/80820
#
#   www.gnu.org  |  "Top (Bash Reference Manual)"  |  https://www.gnu.org/software/bash/manual/html_node/#toc-Shell-Expansions-1
#
#   www.gnu.org  |  "Shell Parameter Expansion (Bash Reference Manual)"  |  https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
#
# ------------------------------------------------------------