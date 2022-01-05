#!/bin/bash
# ------------------------------------------------------------
#
#  Linux - Char-to-Int / Int-to-Char (convert ASCII Code to its associated character, conversion)
#

# Char-to-Int
if [ 1 -eq 1 ]; then
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


# Int-to-Char
if [ 1 -eq 1 ]; then
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