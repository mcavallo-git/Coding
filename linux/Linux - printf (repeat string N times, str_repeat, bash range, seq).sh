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
# Citation(s)
#
#   linuxhint.com  |  "Bash Range"  |  https://linuxhint.com/bash_range/
#
#   www.cyberciti.biz  |  "How to repeat a character 'n' times in Bash - nixCraft"  |  https://www.cyberciti.biz/faq/repeat-a-character-in-bash-script-under-linux-unix/
#
# ------------------------------------------------------------