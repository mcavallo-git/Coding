#!/bin/bash
# ------------------------------------------------------------
#
#	Linux - bash completionisms - fallback value
#
# ------------------------------------------------------------

DEFAULT_VAL="55";
echo "${VARIABLE_NAME_NOT_SETHAYSTACK:-${DEFAULT_VAL}}";
