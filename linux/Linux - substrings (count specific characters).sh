#!/bin/bash

DAT_STRING="lostlhost";
SUBSTRING_ONLY_PERIODS="${DAT_STRING//[^.]}";
COUNT_PERIODS="${#SUBSTRING_ONLY_PERIODS}";
echo "DAT_STRING = \"${DAT_STRING}\"";
echo "COUNT_PERIODS = \"${COUNT_PERIODS}\"";



DAT_STRING="www.example.com";
SUBSTRING_ONLY_PERIODS="${DAT_STRING//[^.]}";
COUNT_PERIODS="${#SUBSTRING_ONLY_PERIODS}";
echo "DAT_STRING = \"${DAT_STRING}\"";
echo "COUNT_PERIODS = \"${COUNT_PERIODS}\"";



# ------------------------------------------------------------
#
#	Citation(s)
#
#		stackoverflow.com  |  "Count occurrences of a char in a string using Bash"  |  https://stackoverflow.com/a/16679640
#
# ------------------------------------------------------------