#!/bin/sh
# ------------------------------------------------------------
# Linux - Command substitution (backticks vs dollar-sign-parenthesis)
# ------------------------------------------------------------


# In short, both `` and $() are used to enclose commands (and optionally pipe their output to a variable or other destination)


#
# SYNTAX A  -->  Dollar-Sign Parenthesis $(...)
#   Using $() is the more logical, and modern, option - It is now fully POSIX compliant, and it came
#   about thanks to Ksh developers introducing it as an alternative to backticks ``
#
DAT_STRING=$(echo 'hello world!';);
echo "${DAT_STRING}";


#
# SYNTAX B  -->  Backticks `...`
#   Using `` is antiquated, and should only be used if you need to ensure your code works 
#   on "very old Bourne shells", as pointed out by Krzysztof Adamski (see Citations).
#
DAT_STRING=`echo 'hello world!';`;
echo "${DAT_STRING}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "bash - Understanding backtick (`) - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/48393
#
# ------------------------------------------------------------