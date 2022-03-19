#!/bin/sh
# ------------------------------------------------------------
# Linux - printf (repeat string N times, str_repeat)
# ------------------------------------------------------------


# Repeat string  -  General syntax (hardcoded count)
printf -- "-%.0s" {1..60};  # Repeat "-" 60 times


# Repeat string  -  General syntax (variable count)
CHAR="-"; COUNT=60; printf -- "${CHAR}%.0s" $(seq ${COUNT});  # Repeat "-" 60 times


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.cyberciti.biz  |  "How to repeat a character 'n' times in Bash - nixCraft"  |  https://www.cyberciti.biz/faq/repeat-a-character-in-bash-script-under-linux-unix/
#
# ------------------------------------------------------------