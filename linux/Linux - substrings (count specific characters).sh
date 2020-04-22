#!/bin/bash
# ------------------------------------------------------------
#
# Linux - Count the number of occurrences of a specific characters in a given string
#
# ------------------------------------------------------------
#
# Method 1 - Using bashisms
#

# Example 1.1
if [ 1 -eq 1 ]; then
  HAYSTACK_TO_SEARCH="localhost";
  NEEDLE_TO_FIND=".";
  ALL_NEEDLES_FOUND="${HAYSTACK_TO_SEARCH//[^${NEEDLE_TO_FIND}]}"; # Required middleman var
  NEEDLE_TOTAL_COUNT=${#ALL_NEEDLES_FOUND};
  echo "HAYSTACK_TO_SEARCH = \"${HAYSTACK_TO_SEARCH}\"";
  echo "NEEDLE_TO_FIND = \"${NEEDLE_TO_FIND}\"";
  echo "NEEDLE_TOTAL_COUNT = \"${NEEDLE_TOTAL_COUNT}\"";
fi;


# Example 1.2
if [ 1 -eq 1 ]; then
  HAYSTACK_TO_SEARCH="www.example.com";
  NEEDLE_TO_FIND=".";
  ALL_NEEDLES_FOUND="${HAYSTACK_TO_SEARCH//[^${NEEDLE_TO_FIND}]}"; # Required middleman var
  NEEDLE_TOTAL_COUNT=${#ALL_NEEDLES_FOUND};
  echo "HAYSTACK_TO_SEARCH = \"${HAYSTACK_TO_SEARCH}\"";
  echo "NEEDLE_TO_FIND = \"${NEEDLE_TO_FIND}\"";
  echo "NEEDLE_TOTAL_COUNT = \"${NEEDLE_TOTAL_COUNT}\"";
fi;


# ------------------------------------------------------------
#
# Method 2 - Using 'tr' and 'awk' --> NEED TO FIX
#

# Example 2.1
# if [ 1 -eq 1 ]; then
#   HAYSTACK_TO_SEARCH="localhost";
#   NEEDLE_TO_FIND=".";
#   ALL_NEEDLES_FOUND="${HAYSTACK_TO_SEARCH//[^${NEEDLE_TO_FIND}]}";
#   NEEDLE_TOTAL_COUNT=$(tr -d -c '"\n' < "${HAYSTACK_TO_SEARCH}" | awk '{ print length; }';);
#   echo "HAYSTACK_TO_SEARCH = \"${HAYSTACK_TO_SEARCH}\"";
#   echo "NEEDLE_TO_FIND = \"${NEEDLE_TO_FIND}\"";
#   echo "NEEDLE_TOTAL_COUNT = \"${NEEDLE_TOTAL_COUNT}\"";
# 	tr -d -c '"\n' < dat | awk '{ print length; }';
# fi;



# ------------------------------------------------------------
#
#	Citation(s)
#
#		stackoverflow.com  |  "Count occurrences of a char in a string using Bash"  |  https://stackoverflow.com/a/16679640
#
#   unix.stackexchange.com  |  "text processing - How to count the number of a specific character in each line? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/18742
#
# ------------------------------------------------------------