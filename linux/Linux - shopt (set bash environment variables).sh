#!/bin/bash
#
# Linux - shopt
#


shopt -s nocasematch; # If set, Bash matches patterns in a case-insensitive fashion when performing matching while executing case or [[ conditional commands, when performing pattern substitution word expansions, or when filtering possible completions as part of programmable completion.


shopt -s globstar; # If set, the pattern ‘**’ used in a filename expansion context will match all files and zero or more directories and subdirectories. If the pattern is followed by a ‘/’, only directories and subdirectories match.


shopt -s lastpipe; # If set, and job control is not active, the shell runs the last command of a pipeline not executed in the background in the current shell environment.
          # |
          # |--> e.g. extends the current shell into sub-shells (within piped-commands), sharing variables down-into them, as well


# ------------------------------------------------------------
#
# Citation(s)
#
# 	gnu.org, "4.2 Bash Builtin Commands", https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#Bash-Builtins
#
# 	gnu.org, "4.3.2 The Shopt Builtin", https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#
# 	ss64.com, "shopt Man Page - Linux - SS64.com", https://ss64.com/bash/shopt.html
#
# ------------------------------------------------------------