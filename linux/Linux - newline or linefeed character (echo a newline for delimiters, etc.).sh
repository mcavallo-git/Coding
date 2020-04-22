#!/bin/bash
# ------------------------------------------------------------
#
# Linux - newline or linefeed character (echo a newline for delimiters, etc.)
#
# ------------------------------------------------------------

LF=$'\n';  # Newline character in Bash


# Example 1.1
echo "First Line"$'\n'"Second Line"$'\n'"Third Line";

# Example 1.2
LF=$'\n'; echo "First Line${LF}Second Line${LF}Third Line";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "Echo newline in Bash prints literal \n - Stack Overflow"  |  https://stackoverflow.com/a/8467448
#
# ------------------------------------------------------------