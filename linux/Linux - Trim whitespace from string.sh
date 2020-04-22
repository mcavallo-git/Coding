#!/bin/bash

STRING_WITH_LEADING_TRAILING_WHITESPACE="$(echo -e "${STRING_WITH_LEADING_TRAILING_WHITESPACE}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "string - How to trim whitespace from a Bash variable? - Stack Overflow"  |  https://stackoverflow.com/a/3232433
#
# ------------------------------------------------------------