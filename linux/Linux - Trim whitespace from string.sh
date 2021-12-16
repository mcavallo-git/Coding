#!/bin/bash

STRING="  a  b  c  d  ";
STRING_TRIMMED="$(echo -e "${STRING}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//';)";
echo "STRING=[${STRING}]";
echo "STRING_TRIMMED=[${STRING_TRIMMED}]";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "string - How to trim whitespace from a Bash variable? - Stack Overflow"  |  https://stackoverflow.com/a/3232433
#
# ------------------------------------------------------------