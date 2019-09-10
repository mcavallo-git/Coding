#!/bin/bash
#
# Linux - shopt
#


shopt -s nocasematch; # If set, Bash matches patterns in a case-insensitive fashion when performing matching while executing case or [[ conditional commands, when performing pattern substitution word expansions, or when filtering possible completions as part of programmable completion.


shopt -s globstar; # If set, the pattern ‘**’ used in a filename expansion context will match all files and zero or more directories and subdirectories. If the pattern is followed by a ‘/’, only directories and subdirectories match.



# ------------------------------------------------------------
#
# Citation(s)
# 	
# 	gnu.org, "4.3.2 The Shopt Builtin", https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#
# 	ss64.com, "shopt Man Page - Linux - SS64.com", https://ss64.com/bash/shopt.html
#
# ------------------------------------------------------------