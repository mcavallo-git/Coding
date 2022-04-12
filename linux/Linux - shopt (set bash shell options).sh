#!/bin/bash
# ------------------------------------------------------------
#
# Linux - shopt
#
# ------------------------------------------------------------
# > shopt --help
# shopt: shopt [-pqsu] [-o] [optname ...]
#     Set and unset shell options.
#
#     Change the setting of each shell option OPTNAME.  Without any option
#     arguments, list each supplied OPTNAME, or all shell options if no
#     OPTNAMEs are given, with an indication of whether or not each is set.
#
#     Options:
#       -o        restrict OPTNAMEs to those defined for use with `set -o'
#       -p        print each shell option with an indication of its status
#       -q        suppress output
#       -s        enable (set) each OPTNAME
#       -u        disable (unset) each OPTNAME
#
#     Exit Status:
#     Returns success if OPTNAME is enabled; fails if an invalid option is
#     given or OPTNAME is disabled.
#
# ------------------------------------------------------------
#
# Enabling a given shopt option
#

shopt -s OPTNAME;  # Replace "OPTNAME" with your desired shopt option


# ------------------------------------------------------------
#
# Examples (common use-cases for shopt):
#

shopt -s nocasematch;  # If set, bash matches patterns in a case-insensitive fashion when performing matching while executing case or [[ conditional commands, when performing pattern substitution word expansions, or when filtering possible completions as part of programmable completion.  (shopt OPTNAME description taken GNU Bash v4.4 manual), from man bash)


shopt -s globstar;  # If set, the pattern ** used in a pathname expansion context will match all files and zero or more directories and subdirectories.  If the pattern is followed by a /, only directories and subdirectories match.  (shopt OPTNAME description taken GNU Bash v4.4 manual), from man bash)


shopt -s lastpipe;  # If set, and job control is not active, the shell runs the last command of a pipeline not executed in the background in the current shell environment.  (shopt OPTNAME description taken GNU Bash v4.4 manual), from man bash)
                    #  |
                    #  |--> e.g. extends the current shell into sub-shells (within piped-commands), sharing variables down-into them, as well


# ------------------------------------------------------------
#
# Citation(s)
#
#   ss64.com  |  "shopt Man Page - Linux - SS64.com"  |  https://ss64.com/bash/shopt.html
#
#   www.gnu.org  |  "Bash Builtins (Bash Reference Manual)"  |  https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#Bash-Builtins
#
#   www.gnu.org  |  "The Shopt Builtin (Bash Reference Manual)"  |  https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#
# ------------------------------------------------------------