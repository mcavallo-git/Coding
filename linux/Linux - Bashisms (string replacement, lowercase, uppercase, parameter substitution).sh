#!/bin/bash
# ------------------------------------------------------------
#
#	Linux - bash completionisms (e.g. bashisms)
#
# ------------------------------------------------------------
#
### Substring Replacement
#
# Syntax:
#         ${VARIABLE_TO_SEARCH//STRING_TO_FIND/STRING_TO_REPLACE_WITH}
#         ${HAYSTACK//${NEEDLE}/${REPLACEMENT}}   <-- using nested variables
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
# SYNTAX:   ${VARNAME,,}
#

EXAMPLE_TO_LOWERCASE="Dat-Example-Doe" && echo "${EXAMPLE_TO_LOWERCASE,,}";


# ------------------------------------------------------------
#
### String variable to-Uppercase
#
# SYNTAX:   ${VARNAME^^}
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
#   stackoverflow.com  |  "Case insensitive comparison of strings in shell script"  |  https://stackoverflow.com/a/19411918
#
#   tldp.org  |  "Manipulating Strings"  |  https://tldp.org/LDP/abs/html/string-manipulation.html
#
#   unix.stackexchange.com  |  "How to input / start a new line in bash terminal?"  |  https://unix.stackexchange.com/a/80820
#
# ------------------------------------------------------------