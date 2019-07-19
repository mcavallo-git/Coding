#!/bin/bash
#
#	RUN VIA GIT BASH:
#
#   "${HOME}/Documents/GitHub/Coding/git/git - find all git.exe configurations (designed to find all git-configs in windows).sh"
#
# ------------------------------------------------------------

ALL_SYSTEM_CONFIGS="${USERPROFILE}/_git_configs.system.txt)";
ALL_GLOBAL_CONFIGS="${USERPROFILE}/_git_configs.globals.txt)";

SEARCH_DIRECTORIES=();
SEARCH_DIRECTORIES+=("${LOCALAPPDATA}/");
SEARCH_DIRECTORIES+=("${PROGRAMFILES}/");
SEARCH_DIRECTORIES+=("${PROGRAMFILES} (x86)/");

for EACH_DIRECTORY in "${SEARCH_DIRECTORIES[@]}"; do

EACH_DIR_REALPATH=$(realpath "${EACH_DIRECTORY}");

find "${EACH_DIR_REALPATH}" \
-name 'git.exe' \
-print0 \
2>"/dev/null" \
| while IFS= read -r -d $'\0' EACH_GIT_EXE; do
EACH_GIT_WIN32=$(realpath "${EACH_GIT_EXE}");
EACH_GIT_LINUX=""; MM="${EACH_GIT_WIN32/C:/\/c}"; MM="${MM//\\/\/}"; EACH_GIT_LINUX=$(realpath "${MM}");

# echo "";
# echo $(ls -al "${EACH_GIT_EXE}");
# echo "------------------------------------------------------------";
# echo "[ ALL ] Git-Configs";
# "${EACH_GIT_EXE}" config --list --show-origin;
# echo "[ SYSTEM ] Git-Configs";
# "${EACH_GIT_EXE}" config --list --show-origin --system;
# echo "[ GLOBAL ] Git-Configs";
# "${EACH_GIT_EXE}" config --list --show-origin --global;

SYSTEM_CONFIG=$("${EACH_GIT_EXE}" config --system --list --show-origin | head -n 1 | sed --regexp-extended --quiet --expression='s/^file\:(.+)\s+(.+)=(.+)$/\1/p');
SYSTEM_ALREADY_NOTED=$(cat "${ALL_SYSTEM_CONFIGS}" | grep "${SYSTEM_CONFIG}");
if [ ! -n "${SYSTEM_ALREADY_NOTED}" ]; then
echo "${SYSTEM_CONFIG}" >> "${ALL_SYSTEM_CONFIGS}"
fi;

GLOBAL_CONFIG=$("${EACH_GIT_EXE}" config --global --list --show-origin | head -n 1 | sed --regexp-extended --quiet --expression='s/^file\:(.+)\s+(.+)=(.+)$/\1/p');
GLOBAL_ALREADY_NOTED=$(cat "${ALL_GLOBAL_CONFIGS}" | grep "${GLOBAL_CONFIG}");
if [ ! -n "${GLOBAL_ALREADY_NOTED}" ]; then
echo "${GLOBAL_CONFIG}" >> "${ALL_GLOBAL_CONFIGS}"
fi;

# echo "------------------------------------------------------------";
done;
done;

echo "";
for EACH_SYSTEM_CONFIG in $(cat ${ALL_SYSTEM_CONFIGS}); do
	echo "SYSTEM CONFIG:    ${EACH_SYSTEM_CONFIG}";
done;

echo "";
for EACH_GLOBAL_CONFIG in $(cat ${ALL_GLOBAL_CONFIGS}); do
	echo "GLOBAL CONFIG:    ${EACH_GLOBAL_CONFIG}";
done;

# echo "ALL_SYSTEM_CONFIGS = [ $(cat ${ALL_SYSTEM_CONFIGS}) ]";
# echo "ALL_GLOBAL_CONFIGS = [ $(cat ${ALL_GLOBAL_CONFIGS}) ]";

# ------------------------------------------------------------
