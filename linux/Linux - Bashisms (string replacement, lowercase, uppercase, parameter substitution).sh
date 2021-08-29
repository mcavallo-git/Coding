#!/bin/bash
# ------------------------------------------------------------
#
#	Linux - bash completionisms (e.g. bashisms)
#
# ------------------------------------------------------------
#
### Left-Trim
#
#   SYNTAX:   ${VARIABLE_TO_TRIM:N}
#                                 ^
#                                 |-- Trims N characters off the left side of the string
#

# Bash Left-Trim Example: Remove the first N characters from a string
VARIABLE_TO_TRIM="ABCDEF";

N=1; echo "${VARIABLE_TO_TRIM:${N}}";
###  Outputs  "BCDEF"

echo "${VARIABLE_TO_TRIM:2}";
###  Outputs  "CDEF"

N=3; echo "${VARIABLE_TO_TRIM:${N}}";
###  Outputs  "DEF"


# ------------------------------------------------------------
#
### Left-Slice
#
#   SYNTAX:   ${VARIABLE_TO_SLICE::N}
#                                  ^
#                                  |-- Keeps N characters from the left side of the string
#

# Bash Left-Slice Example: Remove the first N characters from a string
VARIABLE_TO_SLICE="ABCDEF";

N=1; echo "${VARIABLE_TO_SLICE::${N}}";
###  Outputs  "A"

echo "${VARIABLE_TO_SLICE::2}";
###  Outputs  "AB"

N=4; echo "${VARIABLE_TO_SLICE::${N}}";
###  Outputs  "ABCD"


# ------------------------------------------------------------
#
### Substring Replacement
#
#   SYNTAX:   ${VARIABLE_TO_SEARCH//STRING_TO_FIND/STRING_TO_REPLACE_WITH}
#             ${HAYSTACK//${NEEDLE}/${REPLACEMENT}}   <-- using nested variables
#

# Bash Substring Replacement Exaxmple: Replace dashes with underscores
EXAMPLE_STRING="Bash Substring Replacement - Replace-Dashes-With-Underscores";
MODIFIED_STRING="${EXAMPLE_STRING//-/_}";
echo -e "\nEXAMPLE_STRING=\"${EXAMPLE_STRING}\"\nMODIFIED_STRING=\"${MODIFIED_STRING}\"\m";


# Bash Substring Replacement Exaxmple: Escape spaces with backslashes
EXAMPLE_STRING="Bash Substring Replacement - Escape spaces with backslashes";
MODIFIED_STRING="${EXAMPLE_STRING// /\\ }";
echo -e "\nEXAMPLE_STRING=\"${EXAMPLE_STRING}\"\nMODIFIED_STRING=\"${MODIFIED_STRING}\"\m";


# Bash Substring Replacement Example:  Modular Example inteded for copying/pasting into other script(s)
HAYSTACK="this example, that example";
NEEDLE="th";
REPLACEMENT="d";
MODIFIED_STRING="${HAYSTACK//${NEEDLE}/${REPLACEMENT}}" && echo "${MODIFIED_STRING}";


# ------------------------------------------------------------
#
### String variable to-Lowercase
#
#   SYNTAX:   ${VARNAME,,}
#

EXAMPLE_TO_LOWERCASE="Dat-Example-Doe" && echo "${EXAMPLE_TO_LOWERCASE,,}";


# ------------------------------------------------------------
#
### String variable to-Uppercase
#
#   SYNTAX:   ${VARNAME^^}
#

EXAMPLE_TO_UPPERCASE="Dat-Example-Doe" && echo "${EXAMPLE_TO_UPPERCASE^^}";


# ------------------------------------------------------------
#
### Type-agnostic - Parameter substitution (uses a fallback/default value (or parameter) if primary is unset)

echo "${VAR_NOT_SET:-55}";

# Can fallback to another parameter
DEFAULT_VAL="55" && echo "${VAR_NOT_SET:-${DEFAULT_VAL}}";

# Can be nested
echo "${VAR_NOT_SET:-${VAR_ALSO_NOT_SET:-72}}";


# ------------------------------------------------------------
# Citation(s)
#
#   betterprogramming.pub  |  "24 Bashism To Avoid for POSIX-Compliant Shell Scripts | by Shinichi Okada | Aug, 2021 | Better Programming"  |  https://betterprogramming.pub/24-bashism-to-avoid-for-posix-compliant-shell-scripts-8e7c09e0f49a
#
#   stackoverflow.com  |  "Case insensitive comparison of strings in shell script"  |  https://stackoverflow.com/a/19411918
#
#   stackoverflow.com  |  "Remove first character of a string in Bash - Stack Overflow"  |  https://stackoverflow.com/a/46699430
#
#   tldp.org  |  "Manipulating Strings"  |  https://tldp.org/LDP/abs/html/string-manipulation.html
#
#   unix.stackexchange.com  |  "How to input / start a new line in bash terminal?"  |  https://unix.stackexchange.com/a/80820
#
# ------------------------------------------------------------