#!/bin/bash
#
#	Linux - for loops (using Arrays in Bash)
#
# ------------------------------------------------------------

ARR_USERNAMES=();
ARR_USERNAMES+=("root");
ARR_USERNAMES+=("root");
ARR_USERNAMES+=("$(whoami)");
ARR_USERNAMES+=("ubuntu");
ARR_USERNAMES+=("www-data");
ARR_USERNAMES+=("nginx");
ARR_USERNAMES+=("nginx");
ARR_USERNAMES+=("$(whoami)");
ARR_USERNAMES+=("$(whoami)");

ARR_UNIQUE_USERNAMES=($(echo "${ARR_USERNAMES[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '));

for EACH_UNIQUE_USER in "${ARR_UNIQUE_USERNAMES[@]}"; do
EACH_HOME_DIR=$(getent passwd "${EACH_UNIQUE_USER}" | cut --delimiter=: --fields=6); # $(eval echo ~${EACH_UNIQUE_USER});
if [ -d "${EACH_HOME_DIR}" ]; then
echo "User \"$EACH_UNIQUE_USER\" has a home-directory located at \"${EACH_HOME_DIR}\"";
fi;
done;

# ------------------------------------------------------------

DIR_WIN32_USERS=$(find /mnt/*/Users -mindepth 0 -maxdepth 0 -type d);
find "${DIR_WIN32_USERS}" \
-mindepth 1 \
-maxdepth 1 \
-name '*' \
-type 'd' \
-not -path "${DIR_WIN32_USERS}/Default" \
-not -path "${DIR_WIN32_USERS}/Public" \
-print0 \
| while IFS= read -r -d $'\0' EachUserDir; do
	LastExitCode=$([[ -r "${EachUserDir}/Documents" ]]; echo $?);
	if [ "${LastExitCode}" == "0" ]; then
		if [ "${1}" == "verbose" ]; then echo "PASS - Can read \"${EachUserDir}\" - Current session has sufficient privilege(s)"; fi;
		echo "$(basename ${EachUserDir})" >> "${PotentialUsersFile}";
	else
		if [ "${1}" == "verbose" ]; then echo "FAIL - Cannot read \"${EachUserDir}\" - Current session lacks sufficient privilege(s)"; fi;
		echo "$(basename ${EachUserDir})" >> "${InvalidUsersFile}";
	fi;
done;


# ------------------------------------------------------------

#
# NOTE
#  |--> You can access individual keys via [ echo "${ARR_USERNAMES[0]}" ] , [ "${ARR_USERNAMES[1]}" ] , etc.
#

#
# NOTE
#  |--> Make sure to use BASH ( start script with #!/bin/bash )
#  |--> Attempting to use bashisms like this through "sh" will throw error such as [ Syntax error: "(" unexpected ]
#

# ------------------------------------------------------------
# Example
#  |--> for loop using sort
#  |--> Walk though a list of ".log" extensioned files in alphabetical-order

for EACH_FILE in $(ls /var/log/*.log | sort -V); do
	echo "Found file matching filepath \"/var/log/*.log\": \"${EACH_FILE}\"";
done;



# ------------------------------------------------------------
#
# Citation(s)
#	
#		stackoverflow.com  |  "Loop through an array of strings in Bash?"  |  https://stackoverflow.com/a/8880633
#
#		stackoverflow.com  |  "How do I use a for-each loop to iterate over file paths in bash?"  |  https://stackoverflow.com/a/15066129
#
# ------------------------------------------------------------
