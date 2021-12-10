#!/bin/bash
# ------------------------------------------------------------
# Linux - declare (get the value held in variable whose name is equal to a given string)
# ------------------------------------------------------------


# get the value held in variable whose name is equal to a given string
VAR_NAME="TERM"; \
declare -n VAR_VAL="${VAR_NAME}"; \
echo "VAR_NAME = [ ${VAR_NAME} ]"; \
echo "VAR_VAL  = [ ${VAR_VAL} ]";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "bash - How to get a variable value if variable name is stored as string? - Stack Overflow"  |  https://stackoverflow.com/a/69722647
#
# ------------------------------------------------------------