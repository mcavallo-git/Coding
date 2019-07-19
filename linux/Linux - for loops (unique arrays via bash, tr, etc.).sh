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

#
# NOTE
#  |--> You can access individual keys via [ echo "${ARR_USERNAMES[0]}" ] , [ "${ARR_USERNAMES[1]}" ] , etc.
#

#
# NOTE
#  |--> Make sure to use BASH ( start script with #!/bin/bash )
#  |--> Attempting to use bashisms like this through "sh" will throw error such as [ Syntax error: "(" unexpected ]
#


# Thanks to: https://stackoverflow.com/questions/8880603/loop-through-an-array-of-strings-in-bash


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
