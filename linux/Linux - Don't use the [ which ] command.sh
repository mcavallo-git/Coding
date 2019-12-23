#!/bin/bash
# ------------------------------------------------------------
#
# Alternatives for the  [ which ]  command, to adequately test the existence of local commands, methods, programs, etc.
#

COMMAND_NAME="foo";
command -v foo >/dev/null 2>&1 && { RET_CODE=$?; echo >&2 "[ command -v ${COMMAND_NAME} ] had a return code of [ ${RET_CODE} ] & evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "[ command -v ${COMMAND_NAME} ] had a return code of [ ${RET_CODE} ] & evaluated as [ falsey ]"; }; # Example 1 - Use 'command -v ...' to test for commands
type foo >/dev/null 2>&1 && { RET_CODE=$?; echo >&2 "[ type ${COMMAND_NAME} ] had a return code of [ ${RET_CODE} ] & evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "[ type ${COMMAND_NAME} ] had a return code of [ ${RET_CODE} ] & evaluated as [ falsey ]"; }; # Example 2 - Use 'type ...' to test for commands
hash foo 2>/dev/null && { RET_CODE=$?; echo >&2 "[ hash ${COMMAND_NAME} ] had a return code of [ ${RET_CODE} ] & evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "[ hash ${COMMAND_NAME} ] had a return code of [ ${RET_CODE} ] & evaluated as [ falsey ]"; }; # Example 3 - Use 'hash ...' to test for commands


# ------------------------------------------------------------



# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How to check if a program exists from a Bash script?"  |  https://stackoverflow.com/a/677212
#
# ------------------------------------------------------------