#!/bin/bash
# ------------------------------------------------------------
#
# Linux - Substr using Bashisms
#
# ------------------------------------------------------------
#
# Count the # of characters in a string (e.g. Get the length of a string as an integer value)
#


# Get string length via  [ ${#VAR} ]
VAR="12345"; echo "${#VAR}";       # Outputs "5"
VAR="1234567890"; echo "${#VAR}";  # Outputs "10"


# Get string length via  [ wc -c ]
echo -n "12345" | wc -c;       # Outputs "5"
echo -n "1234567890" | wc -c;  # Outputs "10"


# ------------------------------------------------------------
#
# Trim N characters off of either the left or right side of a string
#


# Right trim via  [ ${Bashism:0:N} ]
N=5;   VAR="1234567890"; echo "${VAR:0:${N}}";  # Outputs "12345"
N=7;   VAR="1234567890"; echo "${VAR:0:${N}}";  # Outputs "1234567"
N=10;  VAR="1234567890"; echo "${VAR:0:${N}}";  # Outputs "1234567890"
N=100; VAR="1234567890"; echo "${VAR:0:${N}}";  # Outputs "1234567890" as well

# Right trim via  [ cut -c1-N ]
N=5;   VAR="1234567890"; echo "${VAR}" | cut -c1-${N};  # Outputs "12345"
N=7;   VAR="1234567890"; echo "${VAR}" | cut -c1-${N};  # Outputs "1234567"
N=10;  VAR="1234567890"; echo "${VAR}" | cut -c1-${N};  # Outputs "1234567890"
N=100; VAR="1234567890"; echo "${VAR}" | cut -c1-${N};  # Outputs "1234567890" as well


# Left trim via   [ ${Bashism: -N} ]
#  |                          ^
#  |-->  ! NOTE ! At least 1 space is required after the colon but before the numeric trim argument
#                             v
N=5;  VAR="1234567890"; echo "${VAR: -${N}}";  # Outputs "67890"
N=7;  VAR="1234567890"; echo "${VAR: -${N}}";  # Outputs "4567890"
N=9;  VAR="1234567890"; echo "${VAR: -${N}}";  # Outputs "234567890"

# Left trim via  [ cut --complement -c1-N ]
N=5;  VAR="1234567890"; echo "${VAR}" | cut --complement -c1-$(echo "$(echo -n "${VAR}"|wc -c;)-${N}"|bc;);  # Outputs "67890"
N=7;  VAR="1234567890"; echo "${VAR}" | cut --complement -c1-$(echo "$(echo -n "${VAR}"|wc -c;)-${N}"|bc;);  # Outputs "4567890"
N=10; VAR="1234567890"; echo "${VAR}" | cut --complement -c1-$(echo "$(echo -n "${VAR}"|wc -c;)-${N}"|bc;);  # Outputs "234567890"


# Left trim Bashism - Boundary Cases:
VAR="1234567890"; echo "${VAR: -11}";  # Outputs ""   !!! BOUNDARY CASE - NEGATIVE VALUE GREATER THAN STRING LENGTH
VAR="1234567890"; echo "${VAR:-5}";    # Outputs "1234567890"   !!! BOUNDARY CASE - SPACE MISSING AFTER COLON ":"


# ---------------

# Trim - Resolving Boundary Cases using "if" conditionals which check string length

# Example - (Trim) Given a PREFIX (string) & a SUFFIX (string), trim the >>> PREFIX <<< down if the concatenation of both PREFIX+SUFFIX is greater than a given character limit

if [ 1 == 1 ]; then
MAX_LENGTH=15;
# USE_LEFTMOST_CHARS=0;
USE_LEFTMOST_CHARS=1;
PREFIX="1234567890";
SUFFIX="abcdefghij";
PREFIX_MAX_LENGTH=$((${MAX_LENGTH}-${#SUFFIX}));
if [ ${#PREFIX} -gt ${PREFIX_MAX_LENGTH} ]; then
  if [ ${USE_LEFTMOST_CHARS} -eq 1 ]; then
    OUTPUT="${PREFIX: 0: ${PREFIX_MAX_LENGTH}}${SUFFIX}";  # Keep the leftmost N characters
  else
    OUTPUT="${PREFIX: -${PREFIX_MAX_LENGTH}}${SUFFIX}";  # Keep the rightmost N characters
  fi;
else
  OUTPUT="${PREFIX: 0: ${PREFIX_MAX_LENGTH}}${SUFFIX}";  # Keep all characters
fi;
echo ${OUTPUT};
fi;


# ---------------

# Example - (Trim) Given a PREFIX (string) & a SUFFIX (string), trim the >>> SUFFIX <<< down if the concatenation of both PREFIX+SUFFIX is greater than a given character limit
if [ 1 == 1 ]; then
MAX_LENGTH=15;
# USE_LEFTMOST_CHARS=0;
USE_LEFTMOST_CHARS=1;
PREFIX="1234567890";
SUFFIX="abcdefghij";
SUFFIX_MAX_LENGTH=$((${MAX_LENGTH}-${#PREFIX}));
if [ ${#SUFFIX} -gt ${SUFFIX_MAX_LENGTH} ]; then
  if [ ${USE_LEFTMOST_CHARS} -eq 1 ]; then
    OUTPUT="${PREFIX}${SUFFIX: 0: ${SUFFIX_MAX_LENGTH}}";  # Keep the leftmost N characters
  else
    OUTPUT="${PREFIX}${SUFFIX: -${SUFFIX_MAX_LENGTH}}";  # Keep the rightmost N characters
  fi;
else
  OUTPUT="${PREFIX}${SUFFIX: 0: ${SUFFIX_MAX_LENGTH}}";  # Keep all characters
fi;
echo ${OUTPUT};
fi;


# ------------------------------------------------------------
#
# Count the number of occurrences of a specific characters in a given string
#

# Example - (Substr) Find a needle in a haystack
if [[ 1 -eq 1 ]]; then
  HAYSTACK_TO_SEARCH="localhost";
  NEEDLE_TO_FIND=".";
  ALL_NEEDLES_FOUND="${HAYSTACK_TO_SEARCH//[^${NEEDLE_TO_FIND}]}";  # Required middleman var
  NEEDLE_TOTAL_COUNT=${#ALL_NEEDLES_FOUND};
  echo "HAYSTACK_TO_SEARCH = \"${HAYSTACK_TO_SEARCH}\"";
  echo "NEEDLE_TO_FIND = \"${NEEDLE_TO_FIND}\"";
  echo "NEEDLE_TOTAL_COUNT = \"${NEEDLE_TOTAL_COUNT}\"";
fi;


# Example - (Substr) Find a needle in a haystack
if [[ 1 -eq 1 ]]; then
  HAYSTACK_TO_SEARCH="www.example.com";
  NEEDLE_TO_FIND=".";
  ALL_NEEDLES_FOUND="${HAYSTACK_TO_SEARCH//[^${NEEDLE_TO_FIND}]}";  # Required middleman var
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
# if [[ 1 -eq 1 ]]; then
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
#   reactgo.com  |  "How to get the last n characters of a string in Bash | Reactgo"  |  https://reactgo.com/bash-get-last-n-characters-string
#
#		stackoverflow.com  |  "Count occurrences of a char in a string using Bash"  |  https://stackoverflow.com/a/16679640
#
#   unix.stackexchange.com  |  "bash - What kinds of string interpolation does POSIX sh support? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/389659
#
#   unix.stackexchange.com  |  "text processing - How to count the number of a specific character in each line? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/18742
#
# ------------------------------------------------------------