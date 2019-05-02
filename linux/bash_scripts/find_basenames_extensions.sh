#!/bin/bash
# ------------------------------------------------------------


# File basename matching:

BASENAME_MUST_BE_EXACTLY="";

BASENAME_MUST_START_WITH="";

BASENAME_MUST_CONTAIN="";

BASENAME_MUST_END_WITH="";



# File extension matching:

EXTENSION_MUST_BE_EXACTLY="pdf";

EXTENSION_MUST_START_WITH="";

EXTENSION_MUST_CONTAIN="";

EXTENSION_MUST_END_WITH="";



# Parent-Directory to search within:

SEARCH_IN_DIRECTORY="${HOME}";



# Extra option(s)

CASE_SENSITIVE_SEARCHING="0";



# ------------------------------------------------------------

# SET VALUES ABOVE, THEN RUN THIS SCRIPT

PATTERN_NAME="";
if [ -n "${BASENAME_MUST_BE_EXACTLY}" ]; then
	PATTERN_NAME="${BASENAME_MUST_BE_EXACTLY}";
else
	if [ -z "${BASENAME_MUST_START_WITH}" ]; then BASENAME_MUST_START_WITH="*"; fi;
	if [ -z "${BASENAME_MUST_CONTAIN}" ]; then BASENAME_MUST_CONTAIN="*"; fi;
	if [ -z "${BASENAME_MUST_END_WITH}" ]; then BASENAME_MUST_END_WITH="*"; fi;
	PATTERN_NAME="${BASENAME_MUST_START_WITH}*${BASENAME_MUST_CONTAIN}*${BASENAME_MUST_END_WITH}";
fi;

PATTERN_EXT="";
if [ -n "${EXTENSION_MUST_BE_EXACTLY}" ]; then
	PATTERN_EXT=".${EXTENSION_MUST_BE_EXACTLY//[.]/}";
else
	if [ -z "${EXTENSION_MUST_START_WITH}" ]; then EXTENSION_MUST_START_WITH="*"; fi;
	if [ -z "${EXTENSION_MUST_CONTAIN}" ]; then EXTENSION_MUST_CONTAIN="*"; fi;
	if [ -z "${EXTENSION_MUST_END_WITH}" ]; then EXTENSION_MUST_END_WITH="*"; fi;
	PATTERN_EXT=".${EXTENSION_MUST_START_WITH//[.]/}*${EXTENSION_MUST_CONTAIN}*${EXTENSION_MUST_END_WITH}";
fi;

PATTERN_FULL="${PATTERN_NAME}${PATTERN_EXT}";

# Replace all back-to-back asterisks '**' with single asterisks '*' in the final glob-pattern
while [ -n "$(echo \"${PATTERN_FULL}\" | grep '\*\*')" ]; do
	PATTERN_FULL="${PATTERN_FULL//'**'/*}";
done;

MATCHES_LIST="";
if [ "${CASE_SENSITIVE_SEARCHING}" == "1" ]; then
	MATCHES_LIST=$(find "${SEARCH_IN_DIRECTORY}" -type 'f' -name "${PATTERN_FULL}");
else
	MATCHES_LIST=$(find "${SEARCH_IN_DIRECTORY}" -type 'f' -iname "${PATTERN_FULL}");
fi;

COUNT_MATCHES=$(echo "$MATCHES_LIST" | wc -l);

echo "${MATCHES_LIST}";

echo -e "\n\n";

echo "	Found ${COUNT_MATCHES} results";

echo -e "\n\n";
echo "  Directory: \"${SEARCH_IN_DIRECTORY}\"";
echo "   Matching: \"${PATTERN_FULL}\"";
echo -e "\n\n";
