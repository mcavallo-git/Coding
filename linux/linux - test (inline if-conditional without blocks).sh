#!/bin/bash
# ------------------------------------------------------------
#
# Linux - test command (acts as an inline if-conditional)
#

test "1" == "0" && echo 1 || echo 0;

TEST_PATH="${HOME}/.bashrc"; test -e "${TEST_PATH}" && echo "Path \"${TEST_PATH}\" DOES exist" || echo "Path \"${TEST_PATH}\" does NOT exist";


# ------------------------------------------------------------
#
# Citation(s)
#
#   ss64.com  |  "test Man Page - Linux - SS64.com"  |  https://ss64.com/bash/test.html
#
# ------------------------------------------------------------