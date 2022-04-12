#!/bin/bash
# ------------------------------------------------------------
# Linux - tr (split string on given character, remove character from string)
# ------------------------------------------------------------

# tr - remove newlines from string
seq 0 9 | tr -d "\n";
# returns: "0123456789"


# ------------------------------------------------------------

# tr - splits strings on a given character
for EACH_PATH in $(manpath | tr ":" "\n"); do echo -e "\n${EACH_PATH}"; ls -al "${EACH_PATH}"; done;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How do I split a string on a delimiter in Bash?"  |  https://stackoverflow.com/a/918931
#
# ------------------------------------------------------------