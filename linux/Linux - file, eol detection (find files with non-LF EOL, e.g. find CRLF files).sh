#!/bin/bash

# Find files which do not contain Linux-style (LF) line-endings (EOL)

INPUT_DIRECTORY="${HOME}/Documents/GitHub/"; # Make sure input-directory ends with a "/" (forward slash)

OUTPUT_RESULTS_TO="${HOME}/Desktop/non-lf-files.log";

clear;

echo "";
echo "  INITIATED FILE-SEARCH";
echo "    |--> PATTERN:  EOL != LF";
echo "    |--> PATTERN:  DIR == \"${INPUT_DIRECTORY}\"";

find "${INPUT_DIRECTORY}" \
-not -type d \
-exec file "{}" ";" \
| grep 'line terminators' \
| sed --regexp-extended --quiet --expression='s/^(.+): .+$/\1/p' \
> "${OUTPUT_RESULTS_TO}";

echo "";
echo "  COMPLETED FILE-SEARCH";
echo "    |--> MATCHED:  $(cat \"${OUTPUT_RESULTS_TO}\" | wc -l) File(s)";
echo "    |--> LOGFILE:  \"${OUTPUT_RESULTS_TO}\"";


### Inline-argument #1 equal to "replace" attempts to automatically correct non-LF line-endings
# if [ -n "$1" ] && [ "$1" == "replace" ]; then
# 	dos2unix --help;
# fi;

echo "";

# ------------------------------------------------------------
#
#	Citation(s)
#
#		stackoverflow.com  |  "How do you search for files containing dos line endings (CRLF) with grep on Linux?"  |  https://stackoverflow.com/a/73969
#
# ------------------------------------------------------------