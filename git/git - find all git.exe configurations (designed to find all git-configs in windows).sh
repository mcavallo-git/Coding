#!/bin/bash

# ------------------------------------------------------------

DAT_ARRAY=(); \
DAT_ARRAY+=("${LOCALAPPDATA}/"); \
DAT_ARRAY+=("${PROGRAMFILES}/"); \
DAT_ARRAY+=("${PROGRAMFILES} (x86)/"); \
for DAT_ITEM in "${DAT_ARRAY[@]}"; do \
SEARCH_IN_DIRECTORY=$(realpath "${DAT_ITEM}"); \
FIND_GIT_EXE=$(find "${SEARCH_IN_DIRECTORY}" -name 'git.exe' 2>/dev/null); \
FIND_GIT_EXE_NO_DUPES=($(echo "${FIND_GIT_EXE[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')); \
for EACH_GIT_EXE in "${FIND_GIT_EXE_NO_DUPES[@]}"; do \
EACH_REALPATH=$(realpath "${EACH_GIT_EXE}"); \
echo ""; \
echo $(ls -al "${EACH_REALPATH}"); \
echo "------------------------------------------------------------"; \
"${EACH_REALPATH}" config --list --show-origin; \
echo "------------------------------------------------------------"; \
done; \
done;

# ------------------------------------------------------------
