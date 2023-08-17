#!/bin/sh
# ------------------------------------------------------------
# Linux - printf (repeat string N times, str_repeat, bash range, seq)
# ------------------------------------------------------------


# Repeat string  -  General syntax (hardcoded count using a bash range)
printf -- "-%.0s" {1..60};  # Repeat "-" 60 times


# Repeat string  -  General syntax (hardcoded count using seq)
printf -- "-%.0s" $(seq 60);  # Repeat "-" 60 times


# Repeat string  -  General syntax (variable count using seq)
CHAR="-"; COUNT=60; printf -- "${CHAR}%.0s" $(seq ${COUNT});  # Repeat "-" 60 times


# ------------------------------------------------------------
#
# Example - printf
#

printf -- '-%.0s' {1..10}; printf " Script started at [ $(date --utc +'%Y-%m-%dT%H:%M:%S.%NZ';) ]\n";


# ------------------------------------------------------------
#
# Citation(s)
#
#   linuxhint.com  |  "Bash Range"  |  https://linuxhint.com/bash_range/
#
#   stackoverflow.com  |  "shell - How can I repeat a character in Bash? - Stack Overflow"  |  https://stackoverflow.com/a/5349842
#
#   unix.stackexchange.com  |  "bash - Dashes in printf - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/22765
#
#   www.cyberciti.biz  |  "How to repeat a character 'n' times in Bash - nixCraft"  |  https://www.cyberciti.biz/faq/repeat-a-character-in-bash-script-under-linux-unix/
#
# ------------------------------------------------------------