#!/bin/bash
# ------------------------------------------------------------
#
# Linux - shopt nocasematch (string case sensitive,sensitivity or insensitive,insensitivity comparisons in bash conditionals)
#
# ------------------------------------------------------------
#
# shopt nocasematch;
#  |
#  |--> If set, bash matches patterns in a case-insensitive fashion when performing matching while executing case or [[ conditional commands, when performing pattern substitution word expansions, or when filtering possible completions as part of programmable completion.  (shopt OPTNAME description taken GNU Bash v4.4 manual), from man bash)
#
# ------------------------------------------------------------
#
# shopt nocasematch - Perform a quick case-insensitive comparison - Make sure to restore case sensitivity setting comparison is made
#

ROLLBACK_SHOPT_NOCASEMATCH="$(shopt | grep '^nocasematch ' | awk '{print $2}';)"; shopt -s nocasematch; # Set string comparisons to be case INsensitive
if [[ "${VARIABLE_TO_TEST}" == "true" ]]; then
  DO_ACTION="true";
else
  DO_ACTION="false";
fi;
if [[ "${ROLLBACK_SHOPT_NOCASEMATCH}" == "off" ]]; then shopt -u nocasematch; fi; # Restore string comparison case sensitivity setting


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "bash - Why isn't the case statement case-sensitive when nocasematch is off? - Stack Overflow"  |  https://stackoverflow.com/a/10695111
#
# ------------------------------------------------------------