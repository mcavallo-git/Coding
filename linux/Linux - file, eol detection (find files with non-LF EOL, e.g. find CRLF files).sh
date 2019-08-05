#!/bin/bash

# Find files which do not contain Linux-style (LF) line-endings (EOL)

INPUT_DIRECTORY="${HOME}/Documents/GitHub/"; # Make sure input-directory ends with a "/" (forward slash)
OUTPUT_RESULTS_TO="${HOME}/Desktop/non-lf-files.log";

echo -e "\n   SEARCHING FOR...";
echo -e "\n     FILES MATCHING:  EOL != LF";
echo -e "\n     IN DIRECTORY:    \"${INPUT_DIRECTORY}\"";

find "${INPUT_DIRECTORY}" -not -type d -exec file "{}" ";" | grep 'line terminators' > "${OUTPUT_RESULTS_TO}";

echo -e "\n   SEARCH FINISHED";
echo -e "\n     FILES MATCHED:  $(cat \"${OUTPUT_RESULTS_TO}\" | wc -l)";
echo -e "\n     LOGFILE PATH:   \"${OUTPUT_RESULTS_TO}\"";


# ------------------------------------------------------------
#
#	Citation(s)
#
#		stackoverflow.com  |  "How do you search for files containing dos line endings (CRLF) with grep on Linux?"  |  https://stackoverflow.com/a/73969
#
# ------------------------------------------------------------