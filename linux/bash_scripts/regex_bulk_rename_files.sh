if [[ 1 -eq 1 ]]; then

# ------------------------------------------------------------

WorkingDir="${HOME}\Downloads";
echo "Setting working-directory to \"${WorkingDir}\"";
cd "${WorkingDir}";

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_([a-zA-Z]+)_(.+)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\3_\1_\2.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Jan)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_01_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Feb)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_02_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Mar)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_03_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Apr)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_04_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(May)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_05_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Jun)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_06_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Jul)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_07_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Aug)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_08_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Sep)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_09_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Oct)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_10_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;


# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Nov)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_11_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(Dec)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1_12_\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

Regex_FilenameMatches="Statement_(.+)_(.+)_(.+)\.pdf";
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\1-\2-\3.pdf/";

if [ -d "${WorkingDir}" ]; then
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";);
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;

# ------------------------------------------------------------

fi;
