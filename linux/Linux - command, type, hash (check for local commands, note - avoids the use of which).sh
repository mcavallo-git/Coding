#!/bin/bash
# ------------------------------------------------------------
#
# Linux - Check for the existence of local commands, methods, programs, etc. while avoiding the command  [ which ]
#

command -v foo 1>'/dev/null' 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }


type foo 1>'/dev/null' 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }


hash foo 2>'/dev/null' || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How to check if a program exists from a Bash script?"  |  https://stackoverflow.com/a/677212
#
# ------------------------------------------------------------