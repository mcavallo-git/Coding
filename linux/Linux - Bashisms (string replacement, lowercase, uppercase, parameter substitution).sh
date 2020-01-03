#!/bin/bash
# ------------------------------------------------------------
#
#	Linux - bash completionisms (e.g. bashisms)
#
# ------------------------------------------------------------
#
### String variable character-replacement, or even substring-replacement
#
# SYNTAX:   ${VARNAME//${NEEDLE}/${REPLACEMENT}}
#

HAYSTACK="this example, that example";
NEEDLE="th";
REPLACEMENT="d";
echo "${HAYSTACK//${NEEDLE}/${REPLACEMENT}}";

EXAMPLE="Dat-Example-Doe" && echo "${EXAMPLE//-/_}";


# ------------------------------------------------------------
#
### String variable to-Lowercase
#
# SYNTAX:   ${VARNAME,,}
#

EXAMPLE="Dat-Example-Doe" && echo "${EXAMPLE,,}";


# ------------------------------------------------------------
#
### String variable to-Uppercase
#
# SYNTAX:   ${VARNAME^^}
#

EXAMPLE="Dat-Example-Doe" && echo "${EXAMPLE^^}";


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
#   unix.stackexchange.com  |  "How to input / start a new line in bash terminal?"  |  https://unix.stackexchange.com/a/80820
#
# ------------------------------------------------------------