#!/bin/bash
# ------------------------------------------------------------
#
#	Linux - bash completionisms - string char replacement, string substring replacement
#
# ------------------------------------------------------------
#

HAYSTACK="this example, that example";
NEEDLE="th";
REPLACEMENT="d";
echo "${HAYSTACK//${NEEDLE}/${REPLACEMENT}}";

#
# ------------------------------------------------------------
#

# test="build-dev-api"; echo "${test//-/_}";

# ------------------------------------------------------------
# Citation(s)
#
#   unix.stackexchange.com  |  "How to input / start a new line in bash terminal?"  |  https://unix.stackexchange.com/a/80820
#
# ------------------------------------------------------------