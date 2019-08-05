#!/bin/bash

# Find files which do not contain Linux-style (LF) line-endings (EOL)

INPUT_DIRECTORY="${HOME}/Documents/GitHub/"; # Make sure input-directory ends with a "/" (forward slash)
OUTPUT_RESULTS_TO="${HOME}/Desktop/non-lf-files.log";

echo -e "\n   INITIATED FILE-SEARCH";
echo -e "\n    |--> PATTERN:  EOL != LF";
echo -e "\n    |--> PATTERN:  DIR == \"${INPUT_DIRECTORY}\"";

find "${INPUT_DIRECTORY}" -not -type d -exec file "{}" ";" | grep 'line terminators' > "${OUTPUT_RESULTS_TO}";

echo -e "\n   COMPLETED FILE-SEARCH";
echo -e "\n    |--> MATCHED:  $(cat \"${OUTPUT_RESULTS_TO}\" | wc -l) File(s)";
echo -e "\n    |--> LOGFILE:  \"${OUTPUT_RESULTS_TO}\"";


# ------------------------------------------------------------
#
#	Citation(s)
#
#		stackoverflow.com  |  "How do you search for files containing dos line endings (CRLF) with grep on Linux?"  |  https://stackoverflow.com/a/73969
#
# ------------------------------------------------------------