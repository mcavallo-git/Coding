#!/bin/bash
# ------------------------------------------------------------
# Linux - Decimal, Hexadecimal, Octal & ASCII character code conversion-converter
# ------------------------------------------------------------
#
# Octal (Base 8)
#  |
#  |--> Syntax:  Leading character "0" before the octal value - such as "010" for 10 as an octal value, or "0100" for 100 as an octal value
#        |
#        |--> Example: "010" is interpreted as the octal value of 10
#        |             "010" is equal to the decimal (base 10) value of 8, being calculated from ((0*8^0)+(1*8))
#        |
#        |--> Example: "0100" is interpreted as the octal value of 100
#                      "0100" is equal to the decimal (base 10) value of 64, being calculated from ((0*8^0)+(0*8)+(1*8^2))
#

if [[ 1 -eq 1 ]]; then
echo "";
VALUE_OCTAL="0100"; echo "VALUE_OCTAL = \"${VALUE_OCTAL}\"";
#
# Octal --> Octal
#
echo -n "0"; printf '%o' "${VALUE_OCTAL}"; echo "   (Octal --> Octal)";
#
# Octal --> Decimal
#
printf '%d' "${VALUE_OCTAL}"; echo "     (Octal --> Decimal)";
#
# Octal --> Hexadecimal
#
echo -n "0x"; printf '%x' "${VALUE_OCTAL}"; echo "   (Octal --> Hexadecimal)";
echo "";
fi;


# ------------------------------------------------------------
#
# Decimal (Base 10)
#  |
#  |--> Syntax:  No leading character(s) before the decimal value - Trying to explain base 10 would be very difficult as it is inherently understood by anyone who would be reading this.
#        |
#        |--> Example: "10" is 10
#        |
#        |--> Example: "100" is 100
#
#

if [[ 1 -eq 1 ]]; then
echo "";
VALUE_DECIMAL="100"; echo "VALUE_DECIMAL = \"${VALUE_DECIMAL}\"";
#
# Decimal --> Octal
#
echo -n "0"; printf '%o' "${VALUE_DECIMAL}"; echo "   (Decimal --> Octal)";
#
# Decimal --> Decimal
#
printf '%d' "${VALUE_DECIMAL}"; echo "    (Decimal --> Decimal)";
#
# Decimal --> Hexadecimal
#
echo -n "0x"; printf '%x' "${VALUE_DECIMAL}"; echo "    (Decimal --> Hexadecimal)";
echo "";
fi;


# ------------------------------------------------------------
#
# Hexadecimal (Base 16)
#  |
#  |--> Syntax:  Leading character(s) "0x" before the hexadecimal value
#        |
#        |--> Example: "0x10" is interpreted as the hexadecimal value of 10
#        |             "0x10" is equal to the decimal (base 10) value of 16, being calculated from ((0*16^0)+(1*16))
#        |
#        |--> Example: "0x100" is interpreted as the hexadecimal value of 100
#                      "0x100" is equal to the decimal (base 10) value of 256, being calculated from ((0*16^0)+(0*16)+(1*16^2))
#


if [[ 1 -eq 1 ]]; then
echo "";
VALUE_HEXADECIMAL="0x100"; echo "VALUE_HEXADECIMAL = \"${VALUE_HEXADECIMAL}\"";
#
# Hexadecimal --> Octal
#
echo -n "0"; printf '%o' "${VALUE_HEXADECIMAL}"; echo "   (Hexadecimal --> Octal)";
#
# Hexadecimal --> Decimal
#
printf '%d' "${VALUE_HEXADECIMAL}"; echo "    (Hexadecimal --> Decimal)";
#
# Hexadecimal --> Hexadecimal
#
echo -n "0x"; printf '%x' "${VALUE_HEXADECIMAL}"; echo "  (Hexadecimal --> Hexadecimal)";
echo "";
fi;


# ------------------------------------------------------------
#
#  ASCII Character Code  -->  Decimal / Hexadecimal / Octal (ASCII Character Code)
#
if [[ 1 -eq 1 ]]; then
ASCII_CHAR="/";
ASCII_INTEGER=$(LC_CTYPE=C printf '%d' "'${ASCII_CHAR}";);
ASCII_HEXADECIMAL="$(printf \\x%x ${ASCII_INTEGER} 2>'/dev/null';)";  # convert integer to hexadecimal
ASCII_OCTAL="$(printf \\%03o ${ASCII_INTEGER} 2>'/dev/null';)";  # convert integer to octal
ASCII_CHARACTER_FROM_HEX="$(printf "${ASCII_HEXADECIMAL}";)";  # get character 
ASCII_CHARACTER_FROM_OCT="$(printf "${ASCII_OCTAL}";)";  # get character 
echo "ASCII_INTEGER=[ ${ASCII_INTEGER} ]";
echo "ASCII_HEXADECIMAL=[ ${ASCII_HEXADECIMAL} ]";
echo "ASCII_OCTAL=[ ${ASCII_OCTAL} ]";
echo "ASCII_CHARACTER_FROM_HEX=[ ${ASCII_CHARACTER_FROM_HEX} ]";
echo "ASCII_CHARACTER_FROM_OCT=[ ${ASCII_CHARACTER_FROM_OCT} ]";
echo "SHORT_COMMAND_GET_CHAR_HEX=[ printf ${ASCII_HEXADECIMAL//\\/\\\\}; ]";
echo "SHORT_COMMAND_GET_CHAR_OCT=[ printf ${ASCII_OCTAL//\\/\\\\}; ]";
fi;


# ------------------------------------------------------------
#
#  Decimal (ASCII Character Code)  -->  ASCII Character Code
#
if [[ 1 -eq 1 ]]; then
ASCII_INTEGER=47;
ASCII_HEXADECIMAL="$(printf \\x%x ${ASCII_INTEGER} 2>'/dev/null';)";  # convert integer to hexadecimal
ASCII_OCTAL="$(printf \\%03o ${ASCII_INTEGER} 2>'/dev/null';)";  # convert integer to octal
ASCII_CHARACTER_FROM_HEX="$(printf "${ASCII_HEXADECIMAL}";)";  # get character 
ASCII_CHARACTER_FROM_OCT="$(printf "${ASCII_OCTAL}";)";  # get character 
echo "ASCII_INTEGER=[ ${ASCII_INTEGER} ]";
echo "ASCII_HEXADECIMAL=[ ${ASCII_HEXADECIMAL} ]";
echo "ASCII_OCTAL=[ ${ASCII_OCTAL} ]";
echo "ASCII_CHARACTER_FROM_HEX=[ ${ASCII_CHARACTER_FROM_HEX} ]";
echo "ASCII_CHARACTER_FROM_OCT=[ ${ASCII_CHARACTER_FROM_OCT} ]";
echo "SHORT_COMMAND_GET_CHAR_HEX=[ printf ${ASCII_HEXADECIMAL//\\/\\\\}; ]";
echo "SHORT_COMMAND_GET_CHAR_OCT=[ printf ${ASCII_OCTAL//\\/\\\\}; ]";
fi;


# ------------------------------------------------------------
#
# SAME AS ABOVE - Just using shorthand syntax
#

if [[ 0 -eq 1 ]]; then

# Building the "?" character in a roundabout way
printf \\%03o 63;  # Returns "\077"
printf \\x%x 63;   # Returns "\077"
printf $(printf \\%03o 63;);  # Returns "?"
printf '\x3f';               # Returns "?"
printf '%b' '\077';          # Returns "?"
printf '\077';               # Returns "?"

# Building the "@" character in a roundabout way
printf $(printf \\%03o 64;);  # Returns "@"
printf '\x40';               # Returns "@"
printf '%b' '\100';          # Returns "@"
printf '\100';               # Returns "@"

fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   lonewolfonline.net  |  "ALL HTML Character Codes (Dingbats, Arrows, ASCII Codes, Miscellaneous, etc.)"  |  https://lonewolfonline.net/html-character-codes-ascii-entity-unicode-symbols/#1
#
#   stackoverflow.com  |  "Integer ASCII value to character in BASH using printf - Stack Overflow"  |  https://stackoverflow.com/a/1754931
#
#   unix.stackexchange.com  |  "Bash script to get ASCII values for alphabet - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/92448
#
# ------------------------------------------------------------