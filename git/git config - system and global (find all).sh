#!/bin/bash
#
#	RUN VIA GIT BASH:
#
#   "${HOME}/Documents/GitHub/Coding/git/git config - system and global (find all).sh"
#
# ------------------------------------------------------------

ROLLBACK_IFS="${IFS}";
IFS=$'\n'; # Set the global for-loop delimiter to newlines (ignore spaces)

ALL_SYSTEM_CONFIGS="${USERPROFILE}/_git_configs.system.txt";
ALL_GLOBAL_CONFIGS="${USERPROFILE}/_git_configs.globals.txt";

echo -n "" > "${ALL_SYSTEM_CONFIGS}";
echo -n "" > "${ALL_GLOBAL_CONFIGS}";

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

		SYSTEM_CONF_PATH=$("${EACH_GIT_LINUX}" config --system --list --show-origin | head -n 1 | sed --regexp-extended --quiet --expression='s/^file\:(.+)\s+(.+)=(.+)$/\1/p');
		SYSTEM_CONF_LINUX=""; MM="${SYSTEM_CONF_PATH/C:/\/c}"; MM="${MM//\\/\/}"; SYSTEM_CONF_LINUX=$(realpath "${MM}");
		SYSTEM_ALREADY_NOTED=$(cat "${ALL_SYSTEM_CONFIGS}" | grep "${SYSTEM_CONF_LINUX}");
		if [ ! -n "${SYSTEM_ALREADY_NOTED}" ]; then
			echo "${SYSTEM_CONF_LINUX}" >> "${ALL_SYSTEM_CONFIGS}";
		fi;

		GLOBAL_CONF_PATH=$("${EACH_GIT_LINUX}" config --global --list --show-origin | head -n 1 | sed --regexp-extended --quiet --expression='s/^file\:(.+)\s+(.+)=(.+)$/\1/p');
		GLOBAL_CONF_LINUX=""; MM="${GLOBAL_CONF_PATH/C:/\/c}"; MM="${MM//\\/\/}"; GLOBAL_CONF_LINUX=$(realpath "${MM}");
		GLOBAL_ALREADY_NOTED=$(cat "${ALL_GLOBAL_CONFIGS}" | grep "${GLOBAL_CONF_LINUX}");
		if [ ! -n "${GLOBAL_ALREADY_NOTED}" ]; then
			echo "${GLOBAL_CONF_LINUX}" >> "${ALL_GLOBAL_CONFIGS}";
		fi;

	done;
done;
# ------------------------------------------------------------

# Show all SYSTEM configuration files-found
echo "";
echo "[SYSTEM] git config file(s) found:";
for EACH_CONFIG in $(cat "${ALL_SYSTEM_CONFIGS}"); do
	echo " ${EACH_CONFIG}";
done;

# Show all GLOBAL configuration files-found
echo "";
echo "[GLOBAL] git config file(s) found:";
for EACH_CONFIG in $(cat "${ALL_GLOBAL_CONFIGS}"); do
	echo "  ${EACH_CONFIG}";
done;

# ------------------------------------------------------------

# Apply a specific [ git config ] value to each file found, call this script with inline-params $1 and $2 as follows:
if [ -n "$1" ]; then

	echo "";
	echo "  [GLOBAL] - Show git configuration value:";
	for EACH_CONFIG in $(cat "${ALL_GLOBAL_CONFIGS}"); do
		echo "    |";
		echo "    |--> $1   (in file: \"${EACH_CONFIG}\")";
		GIT_CONFIG_VALUE=$(git config --file "${EACH_CONFIG}" "$1");
		if [ "$?" != "0" ]; then
			GIT_CONFIG_VALUE=" [NO-VALUE]";
		fi;
		echo "          |-->  ${GIT_CONFIG_VALUE}";
	done;

	if [ -n "$2" ]; then
		echo "  [GLOBAL] - Setting git configuration value:";
		for EACH_CONFIG in $(cat "${ALL_GLOBAL_CONFIGS}"); do
			echo "    |";
			echo "    |--> $1   (in file: \"${EACH_CONFIG}\")";
			echo "          |-->  $2";
			git config --file "${EACH_CONFIG}" --replace-all "$1" "$2";
		done;
	fi;

	echo "";
		echo "  [SYSTEM] - Show git configuration value:";
	for EACH_CONFIG in $(cat "${ALL_SYSTEM_CONFIGS}"); do
		echo "    |";
		echo "    |--> $1   (in file: \"${EACH_CONFIG}\")";
		GIT_CONFIG_VALUE=$(git config --file "${EACH_CONFIG}" "$1");
		if [ "$?" != "0" ]; then
			GIT_CONFIG_VALUE=" [NO-VALUE]";
		fi;
		echo "          |-->  ${GIT_CONFIG_VALUE}";
	done;

	if [ -n "$2" ]; then
		echo "  [SYSTEM] - Setting git configuration value:";
		for EACH_CONFIG in $(cat "${ALL_SYSTEM_CONFIGS}"); do
			echo "    |";
			echo "    |--> $1   (in file: \"${EACH_CONFIG}\")";
			echo "          |-->  $2";
			git config --file "${EACH_CONFIG}" --replace-all "$1" "$2";
		done;
	fi;

else

	echo "";
	echo "Call with inline params \$1 and \$2 to apply a config-value to every config-file found";
	echo "Example:";
	echo "    > \"$0\" core.autocrlf input";

fi;

# ------------------------------------------------------------

echo "";

IFS="${ROLLBACK_IFS}"; # Restore the global for-loop delimiter to whatever the value was at the start of this script's runtime

# ------------------------------------------------------------
