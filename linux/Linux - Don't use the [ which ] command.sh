#!/bin/bash
# ------------------------------------------------------------
#
# Alternatives for the  [ which ]  command, to adequately test the existence of local commands, methods, programs, etc.
#

COMMAND_NAME="foo"; \
echo -e "\n\n"; \
command -v foo >/dev/null 2>&1 && { RET_CODE=$?; echo >&2 "Calling [ command -v ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] & evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ command -v ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] & evaluated as [ falsey ]"; }; \
echo -e "\n\n"; \
type foo >/dev/null 2>&1 && { RET_CODE=$?; echo >&2 "Calling [ type ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] & evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ type ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] & evaluated as [ falsey ]"; }; \
echo -e "\n\n"; \
hash foo 2>/dev/null && { RET_CODE=$?; echo >&2 "Calling [ hash ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] & evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ hash ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] & evaluated as [ falsey ]"; }; \
echo -e "\n\n";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How to check if a program exists from a Bash script?"  |  https://stackoverflow.com/a/677212
#
# ------------------------------------------------------------