if [ 1 -eq 1 ]; then

# ------------------------------------------------------------

WORKING_DIR="${HOME}\Desktop";
echo "Setting working-directory to \"${WORKING_DIR}\"";
cd "${WORKING_DIR}";

DEBUG_MODE=0;  # DEBUG OFF - PERFORM THE RENAMING OF FILES
# DEBUG_MODE=1;  # DEBUG ON - DRY RUNS THE SCRIPT, DOES NOT RENAME FILES

# ------------------------------------------------------------

unset FILENAME_STARTSWITH_ARR; declare -a FILENAME_STARTSWITH_ARR; # [Re-]Instantiate bash array
FILENAME_STARTSWITH_ARR+=("Destiny 2");
FILENAME_STARTSWITH_ARR+=("Halo The Master Chief Collection");
FILENAME_STARTSWITH_ARR+=("MONOPOLY PLUS");
FILENAME_STARTSWITH_ARR+=("No Man's Sky");
FILENAME_STARTSWITH_ARR+=("Override: Mech City Brawl");
FILENAME_STARTSWITH_ARR+=("PHANTASY STAR ONLINE 2");
FILENAME_STARTSWITH_ARR+=("Red Dead Redemption 2");
FILENAME_STARTSWITH_ARR+=("Rocket League");
FILENAME_STARTSWITH_ARR+=("Sea of Thieves");
FILENAME_STARTSWITH_ARR+=("Tom Clancy's The Division 2");
FILENAME_STARTSWITH_ARR+=("Warframe");
FILENAME_STARTSWITH_ARR+=("Warhammer: Vermintide 2");
FILENAME_STARTSWITH_ARR+=("World War Z");
for EACH_FILENAME_STARTSWITH in "${FILENAME_STARTSWITH_ARR[@]}"; do

FILENAME_STARTSWITH="${EACH_FILENAME_STARTSWITH}";
FILENAME_EXTENSION="mp4";
FILENAME_GLOBMATCH="${FILENAME_STARTSWITH}*.${FILENAME_EXTENSION}";

if [ -d "${WORKING_DIR}" ]; then
find . -iname "${FILENAME_GLOBMATCH}" -type f | while read EACH_FILENAME; do
EACH_CREATE_DATE=$(exiftool -s -s -s -createdate "${EACH_FILENAME}" | sed -rne 's/^([0-9]{4}):([0-9]{2}):([0-9]{2})\ ([0-9]{2}):([0-9]{2}):([0-9]{2})$/\1\2\3T\4\5\6/pi';);
EACH_NEW_FILENAME="${FILENAME_STARTSWITH} ${EACH_CREATE_DATE}.${FILENAME_EXTENSION}";
if [ ${DEBUG_MODE} -eq 1 ]; then
echo "------------------------------------------------------------";
echo "EACH_FILENAME:      ${EACH_FILENAME}";
echo "EACH_CREATE_DATE:   ${EACH_CREATE_DATE}";
echo "EACH_NEW_FILENAME:  ${EACH_NEW_FILENAME}";
fi;
if [ ${DEBUG_MODE} -eq 0 ] && [ -n "${EACH_NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${EACH_NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${EACH_NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${EACH_NEW_FILENAME}";
fi;
done;
fi;

done;

# ------------------------------------------------------------

fi;
