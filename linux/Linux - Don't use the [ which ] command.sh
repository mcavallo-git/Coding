#!/bin/bash
# ------------------------------------------------------------
#
# Alternatives for the  [ which ]  command, to adequately test the existence of local commands, methods, programs, etc.
#  |
#  |-->  command -v ___;  (POSIX compatible)
#  |
#  |-->  type ___;
#  |
#  |-->  hash ___;
#


### Force a falsey-condition by testing a command which is known not to exist
COMMAND_NAME=which && \
echo -e "\n\n" &&
command -v ${COMMAND_NAME} >'/dev/null' 2>&1 && { RET_CODE=$?; echo >&2 "Calling [ $(printf '%-20s' "command -v ${COMMAND_NAME}";) ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ command -v ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ falsey ]"; } && \
type ${COMMAND_NAME} >'/dev/null' 2>&1 && { RET_CODE=$?; echo >&2 "Calling [ $(printf '%-20s' "type ${COMMAND_NAME}";) ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ type ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ falsey ]"; } && \
hash ${COMMAND_NAME} 1>'/dev/null' 2>&1 && { RET_CODE=$?; echo >&2 "Calling [ $(printf '%-20s' "hash ${COMMAND_NAME}";) ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ hash ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ falsey ]"; } && \
which ${COMMAND_NAME} 1>'/dev/null' 2>&1 && { RET_CODE=$?; echo >&2 "Calling [ $(printf '%-20s' "which ${COMMAND_NAME}";) ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ which ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ falsey ]"; } && \
echo -e "\n\n";


### Force a truthy-condition by testing a command which is known to exist
COMMAND_NAME=ls && \
echo -e "\n\n" &&
command -v ${COMMAND_NAME} >'/dev/null' 2>&1 && { RET_CODE=$?; echo >&2 "Calling [ $(printf '%-20s' "command -v ${COMMAND_NAME}";) ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ command -v ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ falsey ]"; } && \
type ${COMMAND_NAME} >'/dev/null' 2>&1 && { RET_CODE=$?; echo >&2 "Calling [ $(printf '%-20s' "type ${COMMAND_NAME}";) ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ type ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ falsey ]"; } && \
hash ${COMMAND_NAME} 1>'/dev/null' 2>&1 && { RET_CODE=$?; echo >&2 "Calling [ $(printf '%-20s' "hash ${COMMAND_NAME}";) ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ hash ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ falsey ]"; } && \
which ${COMMAND_NAME} 1>'/dev/null' 2>&1 && { RET_CODE=$?; echo >&2 "Calling [ $(printf '%-20s' "which ${COMMAND_NAME}";) ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ truthy ]"; } || { RET_CODE=$?; echo >&2 "Calling [ which ${COMMAND_NAME} ] yielded a return code of [ ${RET_CODE} ] and was evaluated as [ falsey ]"; } && \
echo -e "\n\n";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How to check if a program exists from a Bash script?"  |  https://stackoverflow.com/a/677212
#
# ------------------------------------------------------------