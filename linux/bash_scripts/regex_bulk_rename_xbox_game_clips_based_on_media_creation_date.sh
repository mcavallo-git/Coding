#!/bin/bash
# ------------------------------------------------------------
#
# Xbox Game clip Renamer
#  |
#  |--> Appens a date-created timestamp onto the filename for Game clips downloaded from 'Xbox Console Companion' (Windows 10) app
#
# ------------------------------------------------------------
if [[ 0 -eq 1 ]]; then # RUN THIS SCRIPT REMOTELY:


curl -H 'Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0' -ssL 'https://raw.githubusercontent.com/mcavallo-git/Coding/master/linux/bash_scripts/regex_bulk_rename_xbox_game_clips_based_on_media_creation_date.sh' | bash -s -- --dry-run 0;  # Xbox Game clip Renamer - Add date-created timestamp to downloaded clips' filenames


### Run in "dry run" mode...
# curl -H 'Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0' -ssL 'https://raw.githubusercontent.com/mcavallo-git/Coding/master/linux/bash_scripts/regex_bulk_rename_xbox_game_clips_based_on_media_creation_date.sh' | bash;  # Xbox Game clip Renamer - Dry-run


### !!! WORKING DIR AS INLINE-ARG IS NON-FUNCTIONAL - NEED TO TROUBLESHOOT !!!
# curl -H "Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" -ssL "https://raw.githubusercontent.com/mcavallo-git/Coding/master/linux/bash_scripts/regex_bulk_rename_xbox_game_clips_based_on_media_creation_date.sh?t=$(date +'%s.%N')" | bash -s -- --dry-run 0 --working-dir "${HOME}/Videos/Captures";


fi;
# ------------------------------------------------------------

DRY_RUN=1;  # DEBUG ON - DRY RUNS THE SCRIPT, DOES NOT RENAME FILES

if [ -n "$(command -v wslpath 2>'/dev/null';)" ]; then  # WSL OS
  DEFAULT_WORKING_DIR="$(wslpath -u "$(wslvar -s "USERPROFILE";)";)/Videos/Captures";
else  # Non-WSL OS
  DEFAULT_WORKING_DIR="${HOME}/Videos/Captures";
fi;

# ------------------------------------------------------------
# Parse inline arguments (passed to current script)

ARGS=("$@");
ARGS_COUNT=${#ARGS[@]};

for (( i=0;i<$ARGS_COUNT;i++ )); do # Walk through any inline-arguments passed to this function

  EACH_ARG=${ARGS[${i}]};

  # Check if this is the last inline-argument or if there are more to follow
  if [ $((${i}+1)) -eq ${ARGS_COUNT} ]; then # if this is the last argument
    NEXT_ARG="";
  else
    NEXT_ARG=${ARGS[$((${i}+1))]};
    if [[ "${NEXT_ARG}" == "--"* ]]; then # Do not allow inline-arguments starting with "--..." to use the next bash-argument as an associated value if it, also, starts with "--..."
      NEXT_ARG="";
    fi;
  fi;

  if [ -n "${EACH_ARG}" ]; then # Parse each non-empty inline argument

    # Parse working-directory declarations
    if [ "${EACH_ARG}" == "--working-dir" ] && [ -n "${NEXT_ARG}" ]; then
      if [ ! -v WORKING_DIR ]; then
        WORKING_DIR="${NEXT_ARG}";
      fi;
    fi;

    # Parse dry-run / non-dry-run calls
    if [ "${EACH_ARG}" == "--force" ]; then # --force
      DRY_RUN=0;  # DEBUG OFF - PERFORM THE RENAMING OF FILES
    elif [ "${EACH_ARG}" == "--dry-run" ] && [ -n "${NEXT_ARG}" ] && [ "${NEXT_ARG}" == "0" ]; then # --dry-run 0
      DRY_RUN=0;  # DEBUG OFF - PERFORM THE RENAMING OF FILES
    elif [ "${EACH_ARG}" == "--dry-run" ] && [ -n "${NEXT_ARG}" ] && [ "${NEXT_ARG}" == "false" ]; then # --dry-run false
      DRY_RUN=0;  # DEBUG OFF - PERFORM THE RENAMING OF FILES
    fi;

  fi;

done;

# ------------------------------------------------------------
#
# Instantiate essential runtime variables (which were not passed as inline-arguments to this script)
#

if [ ! -v WORKING_DIR ]; then
  if [ -v DEFAULT_WORKING_DIR ]; then
    WORKING_DIR="${DEFAULT_WORKING_DIR}";
  fi;
fi;

# ------------------------------------------------------------
if [ ! -d "${WORKING_DIR}" ]; then # Ensure working-directory exists

  echo "";
  echo "Error:  Working-directory not found:  \"${WORKING_DIR}\"";
  echo "";
  echo "Info:  Please [re-]create working-directory, populate it with media-files downloaded from the 'Xbox Console Companion' app, & re-run this script";
  echo "";

else

  echo "";
  echo "Info:  Setting working-directory to \"${WORKING_DIR}\"";
  cd "${WORKING_DIR}";

  unset FILENAME_STARTSWITH_ARR; declare -a FILENAME_STARTSWITH_ARR; # [Re-]Instantiate bash array
  FILENAME_STARTSWITH_ARR+=("Apex Legends");
  FILENAME_STARTSWITH_ARR+=("Battlefield");
  FILENAME_STARTSWITH_ARR+=("Brawl Stars");
  FILENAME_STARTSWITH_ARR+=("Call of Duty");
  FILENAME_STARTSWITH_ARR+=("Clash of Clans");
  FILENAME_STARTSWITH_ARR+=("Cyberpunk 2077");
  FILENAME_STARTSWITH_ARR+=("Destiny 2");
  FILENAME_STARTSWITH_ARR+=("Fallout 76");
  FILENAME_STARTSWITH_ARR+=("Final Fantasy");
  FILENAME_STARTSWITH_ARR+=("Halo The Master Chief Collection");
  FILENAME_STARTSWITH_ARR+=("Minecraft");
  FILENAME_STARTSWITH_ARR+=("MONOPOLY PLUS");
  FILENAME_STARTSWITH_ARR+=("No Man's Sky");
  FILENAME_STARTSWITH_ARR+=("Override Mech City Brawl");
  FILENAME_STARTSWITH_ARR+=("Overwatch");
  FILENAME_STARTSWITH_ARR+=("Phantasy Star Online 2");
  FILENAME_STARTSWITH_ARR+=("Red Dead Redemption 2");
  FILENAME_STARTSWITH_ARR+=("Rocket League");
  FILENAME_STARTSWITH_ARR+=("Sea of Thieves");
  FILENAME_STARTSWITH_ARR+=("Star Wars");
  FILENAME_STARTSWITH_ARR+=("Tom Clancy's The Division 2");
  FILENAME_STARTSWITH_ARR+=("Torchlight");
  FILENAME_STARTSWITH_ARR+=("Ultimate Chicken Horse");
  FILENAME_STARTSWITH_ARR+=("Warframe");
  FILENAME_STARTSWITH_ARR+=("Warhammer Vermintide 2");
  FILENAME_STARTSWITH_ARR+=("World of Warcraft");
  FILENAME_STARTSWITH_ARR+=("World War Z");
  FILENAME_STARTSWITH_ARR+=("Worms W.M.D");

  unset FILE_EXTENSIONS_ARR; declare -a FILE_EXTENSIONS_ARR; # [Re-]Instantiate bash array
  FILE_EXTENSIONS_ARR+=("mp4");
  FILE_EXTENSIONS_ARR+=("png");

  for EACH_FILE_EXTENSION in "${FILE_EXTENSIONS_ARR[@]}"; do

    if [ ${DRY_RUN} -eq 1 ]; then
      echo "************************************************************";
      echo "EACH_FILE_EXTENSION: ${EACH_FILE_EXTENSION}";
    fi;

    for EACH_FILENAME_STARTSWITH in "${FILENAME_STARTSWITH_ARR[@]}"; do

      FILENAME_STARTSWITH="${EACH_FILENAME_STARTSWITH}";
      FILENAME_GLOBMATCH="${FILENAME_STARTSWITH}*.${EACH_FILE_EXTENSION}";

      if [ ${DRY_RUN} -eq 1 ]; then
        echo "============================================================";
        echo "FILENAME_STARTSWITH: ${FILENAME_STARTSWITH}";
        echo "FILENAME_GLOBMATCH: ${FILENAME_GLOBMATCH}";
      fi;

      if [ -d "${WORKING_DIR}" ]; then

        find . -iname "${FILENAME_GLOBMATCH}" -type f | while read EACH_FILENAME; do

          EACH_CREATE_DATE=$(exiftool -s -s -s -createdate "${EACH_FILENAME}" | sed -rne 's/^([0-9]{4}):([0-9]{2}):([0-9]{2})\ ([0-9]{2}):([0-9]{2}):([0-9]{2})$/\1\2\3T\4\5\6/pi';);

          EACH_NEW_FILENAME="${FILENAME_STARTSWITH} ${EACH_CREATE_DATE}.${EACH_FILE_EXTENSION}";

          if [ ${DRY_RUN} -ne 0 ]; then  # Running in dry-run mode

            echo "------------------------------------------------------------";
            echo "EACH_FILENAME:       ${EACH_FILENAME}";
            echo "EACH_CREATE_DATE:    ${EACH_CREATE_DATE}";
            echo "EACH_NEW_FILENAME:   ${EACH_NEW_FILENAME}   !!! Skipping File-Rename (Dry-Run Mode) !!!";

          else  # NOT running in dry-run mode

            if [ -n "${EACH_CREATE_DATE}" ]; then  # If the created-on date resolved as-intended
              if [ -n "${EACH_NEW_FILENAME}" ]; then   # If new filename is not blank
                if [ "${EACH_FILENAME}" != "${EACH_NEW_FILENAME}" ]; then   # If new filename is not equal to original filename
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
