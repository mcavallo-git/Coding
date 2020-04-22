#!/bin/bash
# ------------------------------------------------------------
#
# Linux - Count the number of occurrences of a specific characters in a given string
#
# ------------------------------------------------------------
#
# Method 1 - Using bashisms
#

HAYSTACK_TO_SEARCH="localhost";
NEEDLE_TO_FIND=".";
ALL_NEEDLES_FOUND="${HAYSTACK_TO_SEARCH//[^${NEEDLE_TO_FIND}]}";
NEEDLE_TOTAL_COUNT="${#ALL_NEEDLES_FOUND}";
echo "HAYSTACK_TO_SEARCH = \"${HAYSTACK_TO_SEARCH}\"";
echo "NEEDLE_TO_FIND = \"${NEEDLE_TO_FIND}\"";
echo "NEEDLE_TOTAL_COUNT = \"${NEEDLE_TOTAL_COUNT}\"";


FIND_PERIODS_IN="localhost";
SUBSTRING_ONLY_PERIODS="${FIND_PERIODS_IN//[^.]}";
COUNT_PERIODS="${#SUBSTRING_ONLY_PERIODS}";
echo "FIND_PERIODS_IN = \"${FIND_PERIODS_IN}\"";
echo "COUNT_PERIODS = \"${COUNT_PERIODS}\"";


FIND_PERIODS_IN="www.example.com";
SUBSTRING_ONLY_PERIODS="${FIND_PERIODS_IN//[^.]}";
COUNT_PERIODS="${#SUBSTRING_ONLY_PERIODS}";
echo "FIND_PERIODS_IN = \"${FIND_PERIODS_IN}\"";
echo "COUNT_PERIODS = \"${COUNT_PERIODS}\"";


# ------------------------------------------------------------
#
# Method 2 - Using 'tr' and 'awk'
#

tr -d -c '"\n' < dat | awk '{ print length; }';



# ------------------------------------------------------------
#
#	Citation(s)
#
#		stackoverflow.com  |  "Count occurrences of a char in a string using Bash"  |  https://stackoverflow.com/a/16679640
#
#   unix.stackexchange.com  |  "text processing - How to count the number of a specific character in each line? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/18742
#
# ------------------------------------------------------------