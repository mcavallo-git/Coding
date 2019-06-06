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