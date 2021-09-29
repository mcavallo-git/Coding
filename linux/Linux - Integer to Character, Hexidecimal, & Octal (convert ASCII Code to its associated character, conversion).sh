#!/bin/bash
# ------------------------------------------------------------
#
#  Linux - Int to Char (convert ASCII Code to its associated character, conversion)
#


if [ 1 -eq 1 ]; then
ASCII_INTEGER="63";
ASCII_HEXADECIMAL="$(printf \\x%x ${ASCII_INTEGER})";  # convert integer to hexadecimal
ASCII_OCTAL="$(printf \\%03o ${ASCII_INTEGER})";  # convert integer to octal
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


if [ 0 -eq 1 ]; then
printf \\%03o 63;  # \077
printf \\x%x 63;  # \077

printf $(printf \\%03o 63);  # ?
printf '\x3f';  # ?
printf '%b' '\077';  # ?
printf '\077';  # ?
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "Integer ASCII value to character in BASH using printf - Stack Overflow"  |  https://stackoverflow.com/a/1754931
#
#   lonewolfonline.net  |  "ALL HTML Character Codes (Dingbats, Arrows, ASCII Codes, Miscellaneous, etc.)"  |  https://lonewolfonline.net/html-character-codes-ascii-entity-unicode-symbols/#1
#
# ------------------------------------------------------------