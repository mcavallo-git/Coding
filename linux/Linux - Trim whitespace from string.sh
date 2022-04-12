#!/bin/bash
# ------------------------------------------------------------

# trim string to specific length
STRING="$(seq 0 9 | tr -d "\n";)";  # Repeat "-" 60 times)";
STRING_TRIMMED="$(echo -e "${STRING}" | awk "{print substr(\$0,5,${#STRING})}";)";
echo -e "\nSTRING=[${STRING}]\nSTRING_TRIMMED=[${STRING_TRIMMED}]\n";
# returns:
# STRING=[0123456789]
# STRING_TRIMMED=[456789]


# ------------------------------------------------------------

# trim whitespace from a string
STRING="  a  b  c  d  ";
STRING_TRIMMED="$(echo -e "${STRING}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//';)";
echo -e "\nSTRING=[${STRING}]\nSTRING_TRIMMED=[${STRING_TRIMMED}]\n";
# returns:
# STRING=[  a  b  c  d  ]
# STRING_TRIMMED=[a  b  c  d]


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "string - How to trim whitespace from a Bash variable? - Stack Overflow"  |  https://stackoverflow.com/a/3232433
#
#   unix.stackexchange.com  |  "linux - Trim lines to a specific length - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/446965
#
# ------------------------------------------------------------