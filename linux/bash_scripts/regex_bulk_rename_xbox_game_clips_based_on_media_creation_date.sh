#!/bin/bash
# ------------------------------------------------------------
if [ 0 -eq 1 ]; then # RUN THIS SCRIPT REMOTELY:

curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -ssL "https://raw.githubusercontent.com/mcavallo-git/Coding/master/linux/bash_scripts/regex_bulk_rename_xbox_game_clips_based_on_media_creation_date.sh?t=$(date +'%s.%N')" | bash;

fi;
# ------------------------------------------------------------

# DEBUG_MODE=0;  # DEBUG OFF - PERFORM THE RENAMING OF FILES
DEBUG_MODE=1;  # DEBUG ON - DRY RUNS THE SCRIPT, DOES NOT RENAME FILES

# ------------------------------------------------------------

WORKING_DIR="${HOME}/Videos/Captures";

if [ ! -d "${WORKING_DIR}" ]; then

	echo "";
	echo "Error:  Working-directory not found: ${WORKING_DIR}";
	echo "";
	echo "Info:  Please [re-]create working-directory, populate it with media-files downloaded from the 'Xbox Console Companion' app, & re-run this script";
	echo "";

else

	echo "";
	echo "Info:  Setting working-directory to \"${WORKING_DIR}\"";
	cd "${WORKING_DIR}";


	# ------------------------------------------------------------

	unset FILENAME_STARTSWITH_ARR; declare -a FILENAME_STARTSWITH_ARR; # [Re-]Instantiate bash array
	FILENAME_STARTSWITH_ARR+=("Destiny 2");
	FILENAME_STARTSWITH_ARR+=("Fallout 76");
	FILENAME_STARTSWITH_ARR+=("Halo The Master Chief Collection");
	FILENAME_STARTSWITH_ARR+=("MONOPOLY PLUS");
	FILENAME_STARTSWITH_ARR+=("No Man's Sky");
	FILENAME_STARTSWITH_ARR+=("Override Mech City Brawl");
	FILENAME_STARTSWITH_ARR+=("Overwatch");
	FILENAME_STARTSWITH_ARR+=("Phantasy Star Online 2");
	FILENAME_STARTSWITH_ARR+=("Red Dead Redemption 2");
	FILENAME_STARTSWITH_ARR+=("Rocket League");
	FILENAME_STARTSWITH_ARR+=("Sea of Thieves");
	FILENAME_STARTSWITH_ARR+=("Tom Clancy's The Division 2");
	FILENAME_STARTSWITH_ARR+=("Warframe");
	FILENAME_STARTSWITH_ARR+=("Warhammer Vermintide 2");
	FILENAME_STARTSWITH_ARR+=("World War Z");

	unset FILE_EXTENSIONS_ARR; declare -a FILE_EXTENSIONS_ARR; # [Re-]Instantiate bash array
	FILE_EXTENSIONS_ARR+=("mp4");
	FILE_EXTENSIONS_ARR+=("png");

	for EACH_FILE_EXTENSION in "${FILE_EXTENSIONS_ARR[@]}"; do

		if [ ${DEBUG_MODE} -eq 1 ]; then
			echo "************************************************************";
			echo "EACH_FILE_EXTENSION: ${EACH_FILE_EXTENSION}";
		fi;

		for EACH_FILENAME_STARTSWITH in "${FILENAME_STARTSWITH_ARR[@]}"; do

			FILENAME_STARTSWITH="${EACH_FILENAME_STARTSWITH}";
			FILENAME_GLOBMATCH="${FILENAME_STARTSWITH}*.${EACH_FILE_EXTENSION}";

			if [ ${DEBUG_MODE} -eq 1 ]; then
				echo "============================================================";
				echo "FILENAME_STARTSWITH: ${FILENAME_STARTSWITH}";
				echo "FILENAME_GLOBMATCH: ${FILENAME_GLOBMATCH}";
			fi;

			if [ -d "${WORKING_DIR}" ]; then

				find . -iname "${FILENAME_GLOBMATCH}" -type f | while read EACH_FILENAME; do

					EACH_CREATE_DATE=$(exiftool -s -s -s -createdate "${EACH_FILENAME}" | sed -rne 's/^([0-9]{4}):([0-9]{2}):([0-9]{2})\ ([0-9]{2}):([0-9]{2}):([0-9]{2})$/\1\2\3T\4\5\6/pi';);

					EACH_NEW_FILENAME="${FILENAME_STARTSWITH} ${EACH_CREATE_DATE}.${EACH_FILE_EXTENSION}";

					if [ ${DEBUG_MODE} -eq 1 ]; then
						echo "------------------------------------------------------------";
						echo "EACH_FILENAME:       ${EACH_FILENAME}";
						echo "EACH_CREATE_DATE:    ${EACH_CREATE_DATE}";
						echo "EACH_NEW_FILENAME:   ${EACH_NEW_FILENAME}";
					fi;

					if [ ${DEBUG_MODE} -eq 0 ]; then  # If not running in dry-run mode
						if [ -n "${EACH_CREATE_DATE}" ]; then  # If the created-on date resolved as-intended
							if [ -n "${EACH_NEW_FILENAME}" ]; then  # If new filename is not blank
								if [ "${EACH_FILENAME}" != "${EACH_NEW_FILENAME}" ]; then  # If new filename is not equal to original filename
									# Rename the file
									echo "  Renaming \"${EACH_FILENAME}\" to \"${EACH_NEW_FILENAME}\"";
									mv "${EACH_FILENAME}" "${EACH_NEW_FILENAME}";
								fi;
							fi;
						fi;
					fi;

				done;

			fi;

		done;

	done;

fi;

# ------------------------------------------------------------

fi;

# ------------------------------------------------------------