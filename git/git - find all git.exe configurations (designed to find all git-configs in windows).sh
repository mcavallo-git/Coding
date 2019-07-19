#!/bin/bash

# ------------------------------------------------------------

DAT_ARRAY=();
DAT_ARRAY+=("${LOCALAPPDATA}/");
DAT_ARRAY+=("${PROGRAMFILES}/");
DAT_ARRAY+=("${PROGRAMFILES} (x86)/");
for DAT_ITEM in "${DAT_ARRAY[@]}"; do
SEARCH_IN_DIRECTORY=$(realpath "${DAT_ITEM}");
FIND_GIT_EXE=$(find "${SEARCH_IN_DIRECTORY}" -name 'git.exe' 2>/dev/null);
FIND_GIT_EXE_NO_DUPES=($(echo "${FIND_GIT_EXE[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '));
find "${SEARCH_IN_DIRECTORY}" \
-name 'git.exe' \
2>"/dev/null" \
-print0 \
| while IFS= read -r -d $'\0' EACH_ITEM; do
EACH_REALPATH=$(realpath "${EACH_ITEM}");
echo "";
echo $(ls -al "${EACH_REALPATH}");
echo "------------------------------------------------------------";
"${EACH_REALPATH}" config --list --show-origin;
echo "------------------------------------------------------------";
done;
done;

# ------------------------------------------------------------
