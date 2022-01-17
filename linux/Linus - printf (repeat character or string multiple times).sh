#!/bin/bash
# ------------------------------------------------------------
#
# Repeating a character in Linux using printf
#

printf '=%.0s' {1..60};


# ------------------------------------------------------------
#
# NOTE: Dashes must be handled differently with printf
#

printf -- '-%.0s' {1..60};

SEPARATOR="$(printf -- '-%.0s' {1..60};)"; echo ${SEPARATOR};


# ------------------------------------------------------------
#
# Example - printf
#

printf -- '-%.0s' {1..10}; printf " Script started at [ $(date --utc +'%Y-%m-%dT%H:%M:%S.%NZ';) ]\n";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "shell - How can I repeat a character in Bash? - Stack Overflow"  |  https://stackoverflow.com/a/5349842
#
#   unix.stackexchange.com  |  "bash - Dashes in printf - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/22765
#
# ------------------------------------------------------------