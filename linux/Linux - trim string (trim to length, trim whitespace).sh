#!/bin/bash
# ------------------------------------------------------------
# Linux - trim string (trim to length, trim whitespace)
# ------------------------------------------------------------

# trim string to specific length

STRING="12345678901234567890123456789012345678901234567890";
START_CHAR="25";
END_CHAR="${#STRING}";
STRING_TRIMMED="$(echo -e "${STRING}" | awk "{print substr(\$0,${START_CHAR},${END_CHAR})}";)";
echo -e "\nSTRING=[${STRING}]\nSTRING_TRIMMED=[${STRING_TRIMMED}]\n";
# returns:
# STRING=[12345678901234567890123456789012345678901234567890]
# STRING_TRIMMED=[56789012345678901234567890]


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