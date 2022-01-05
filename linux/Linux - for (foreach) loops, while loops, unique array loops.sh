#!/bin/bash
#
# Linux - for loops (examples)
#
# ------------------------------------------------------------
#
#   Note: You can access individual keys via [ echo "${ARR_USERNAMES[0]}" ] , [ "${ARR_USERNAMES[1]}" ] , etc.
#   Note: Make sure to use BASH ( start script with #!/bin/bash ) --> Attempting to use bashisms like this through "sh" will throw error such as [ Syntax error: "(" unexpected ]
#
# ------------------------------------------------------------
#
#   For-Loop(s)
#


# For-loop - Integer iteration ( using range {START..END} syntax ) - Bash 3.0+ only
for i in {1..10}; do echo "\$i = ${i}"; done;


# For-loop - Integer iteration ( using 'seq' command and a variable iteration counter)
LOOP_ITERATIONS=1000; for i in $(seq ${LOOP_ITERATIONS}); do echo "\$i = ${i}"; done;


# For-loop - Integer iteration - BREAK the loop if a specific condition occurs
LOOP_ITERATIONS=1000; for i in $(seq ${LOOP_ITERATIONS}); do echo "\$i = ${i}"; if [[ "${i}" -eq 257 ]]; then break; fi; done;


# For-loop - Integer iteration ( using range {START..END..INCREMENT} syntax ) - Bash 4.0+ only
for i in {1..10..2}; do
echo "\$i = ${i}";
done;


# For-loop on a predefined Indexed Array (?) (in Bash)
for EACH_DOMAIN in "google.com" "hotmail.com" "microsoft.com" "yahoo.com"; do
echo "";
echo -n "EACH_DOMAIN=[ $(printf '%-15s' "${EACH_DOMAIN}";) ]   "; echo | openssl s_client -servername "${EACH_DOMAIN}" -connect "${EACH_DOMAIN}:443" 2>'/dev/null' | openssl x509 -noout -dates | grep 'notAfter';
echo "";
done;


# For-loop on an Indexed Array (in Bash)
unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY+=("Val-1");
DAT_ARRAY+=("Val-2");
DAT_ARRAY+=("Val-3");
DAT_ARRAY+=("Val-4");
for DAT_ITEM in "${DAT_ARRAY[@]}"; do
echo "------------------------------";
echo "${DAT_ITEM}";
done;


# For-loop on an Associative Array (in Bash)
unset DAT_ARRAY; declare -A DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY+=(["Key A"]="Val One");
DAT_ARRAY+=(["Key B"]="Val Two");
DAT_ARRAY+=(["Key A"]="Overwrite A");
DAT_ARRAY+=(["Key B"]="Overwrite B");
for DAT_KEY in "${!DAT_ARRAY[@]}"; do
DAT_ITEM="${DAT_ARRAY[${DAT_KEY}]}";
echo "DAT_ARRAY[${DAT_KEY}] = ${DAT_ITEM}";
done;


# For-loop integer iteration using range {START..END} syntax, such as {1..10}
if [ $(echo "${BASH_VERSION}" | cut --delimiter="." --fields=1;) -ge 3 ]; then
for i in {1..10}; do echo "\$i = ${i}"; done;
else
echo "Bash 3.0+ is required to use [ for-loop integer iteration using range {START..END} ] syntax - current bash version is [ ${BASH_VERSION} ]";
for i in $(seq 10); do echo "\$i = ${i}"; done;
fi;


# For-loop integer iteration using range {START..END..INCREMENT} syntax, such as {1..10..2}
if [ $(echo "${BASH_VERSION}" | cut --delimiter="." --fields=1;) -ge 4 ]; then
for i in {1..10..2}; do echo "\$i = ${i}"; done;
else
echo "Bash 4.0+ is required to use [ for-loop integer iteration using range {START..END..INCREMENT} ] syntax - current bash version is [ ${BASH_VERSION} ]";
fi;


# For-loop, ITERATE + CONDITIONAL (counts from 1 to n - defined in $(seq X), breaks if given conditional is matched)
MAX_ITERATIONS=120;
for i in $(seq ${MAX_ITERATIONS}); do
  VM_HEARTBEAT_STATUS=$(sshpass -p ${ESXI_CREDS_PASS} ssh "${ESXI_CREDS_USER}@${ESXi_HOSTNAME_IPV4}" -C "vim-cmd vmsvc/get.guestheartbeatStatus ${ID_VM}";);
  if [ "${VM_HEARTBEAT_STATUS}" == "green" ]; then
    break;
  fi;
  sleep 1;
done;


# For-loop, PARSE (uses default IFS delimiter - pulled from stock Ubuntu 19.04 file "/etc/profile"))
if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi


# For-loop, PARSE (for each substring in a comma delimited string)
EXAMPLE_COMMA_DELIMITATION="abc,def,ghij";
for i in $(echo ${EXAMPLE_COMMA_DELIMITATION} | sed "s/,/ /g"); do
  echo "$i";
done;


# ------------------------------------------------------------
#
#   ForEach-Loop(s)
#


# ForEach file returned by a 'find' query
if [[ 1 -eq 1 ]]; then
  DASH_NL="------------------------------------------------------------\n";
  for EACH_SERVICE_FILE in $(find "/etc/init.d" -type "f";); do
    if [[ "$(cat "${EACH_SERVICE_FILE}" | grep 'status)' | wc -l;)" -gt 0 ]]; then
      EACH_SERVICE_STATUS="$(${EACH_SERVICE_FILE} status 2>&1;)";
      if [[ -n "${EACH_SERVICE_STATUS}" ]]; then
        echo -e "${DASH_NL}\nCalling [ ${EACH_SERVICE_FILE} status; ]...\n";
        ${EACH_SERVICE_FILE} status; SERVICE_EXIT_CODE=${?};
        echo "";
        echo "SERVICE_EXIT_CODE = [ ${SERVICE_EXIT_CODE} ]";
        echo "";
      fi;
    fi;
  done;
  echo -e "${DASH_NL}";
fi;


# ForEach loop using newline delimiter
if [[ 1 -eq 1 ]]; then
  ROLLBACK_IFS="${IFS}"; IFS=$'\n'; # Set the global for-loop delimiter
  for EACH_LINE in $(ps aux); do
  echo "------------------------------------------------------------";
  echo "${EACH_LINE}";
  done;
  IFS="${ROLLBACK_IFS}"; # Restore the global for-loop delimiter
fi;


# ------------------------------------------------------------
#
#   While-Loops
#

# While-loop, PARSE (using newline delimiter)
ps aux | while read -r -d $'\n' EACH_LINE; do \
echo "------------------------------------------------------------"; \
echo "${EACH_LINE}"; \
done;


# While-loop, CONDITIONAL (waits indefinitely for given conditional to be true)
VM_HEARTBEAT_STATUS="gray";
while [ "${VM_HEARTBEAT_STATUS}" != "green" ]; do VM_HEARTBEAT_STATUS=$(sshpass -p ${ESXI_CREDS_PASS} ssh "${ESXI_CREDS_USER}@${ESXi_HOSTNAME_IPV4}" -C "vim-cmd vmsvc/get.guestheartbeatStatus ${ID_VM}";); sleep 1; done; # Wait until VM heartbeat shows online (green)


# While-loop, INFINITE (until user cancels, terminal ends, or machine stops)
while [ 1 ]; do date; sleep 1; done; # Show the time, once per second (until process is killed/cancelled)

while [ 1 ]; do echo "$(date +'%Y-%m-%d %H:%M:%S') | size: [ $(du -s /var/www) ], files: [ $(find /var/www | wc -l) ]"; sleep 15; done; # show the size of target dir once every 15s


# ------------------------------------------------------------
#
# ForEach item in an array
#

if [[ 1 -eq 1 ]]; then

  ARR_USERNAMES=();
  ARR_USERNAMES+=("root");
  ARR_USERNAMES+=("root");
  ARR_USERNAMES+=("$(whoami)");
  ARR_USERNAMES+=("ubuntu");
  ARR_USERNAMES+=("www-data");
  ARR_USERNAMES+=("nginx");
  ARR_USERNAMES+=("nginx");
  ARR_USERNAMES+=("$(whoami;)");

  ARR_UNIQUE_USERNAMES=($(echo "${ARR_USERNAMES[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ';));

  for EACH_UNIQUE_USER in "${ARR_UNIQUE_USERNAMES[@]}"; do
    EACH_HOME_DIR=$(getent passwd "${EACH_UNIQUE_USER}" | cut --delimiter=: --fields=6); # $(eval echo ~${EACH_UNIQUE_USER});
    if [ -d "${EACH_HOME_DIR}" ]; then
      echo "User \"$EACH_UNIQUE_USER\" has a home-directory located at \"${EACH_HOME_DIR}\"";
    fi;
  done;

fi;


# ------------------------------------------------------------
#
# ForEach line in a file - using IFS=$'\n'

if [[ 1 -eq 1 ]]; then

  # Create a mock file
  MOCK_FILE="/tmp/test-foreach-$(date +'%Y%m%d_%H%M%S')";
  if [ -f "${MOCK_FILE}" ]; then rm -rfv "${MOCK_FILE}"; fi;

  # Add "Line 1", "Line 2", ..., "Line N" to the mock file
  N_LINES=10; for i in $(seq ${N_LINES}); do echo "Line ${i}" >> "${MOCK_FILE}"; done;

  # Parse each line in the mock file
  ROLLBACK_IFS="${IFS}"; IFS=$'\n'; # Set the global for-loop delimiter
  for EACH_LINE in $(cat "${MOCK_FILE}";); do
    echo "------------------------------";
    echo "${EACH_LINE}";
  done;
  IFS="${ROLLBACK_IFS}"; # Restore the global for-loop delimiter

  # Clean up the mock file
  if [ -f "${MOCK_FILE}" ]; then rm -rfv "${MOCK_FILE}"; fi;

fi;


# ------------------------------------------------------------
#
# ForEach line in a file - using 'while read'
#

if [[ 1 -eq 1 ]]; then

  # Create a mock file
  MOCK_FILE="/tmp/test-foreach-$(date +'%Y%m%d_%H%M%S')";
  if [ -f "${MOCK_FILE}" ]; then rm -rfv "${MOCK_FILE}"; fi;

  # Add "Line 1", "Line 2", ..., "Line N" to the mock file
  N_LINES=10; for i in $(seq ${N_LINES}); do echo "Line ${i}" >> "${MOCK_FILE}"; done;

  # Parse each line in the mock file
  cat "${MOCK_FILE}" | while read EACH_LINE; do
    echo "------------------------------";
    echo "${EACH_LINE}";
  done;

  # Clean up the mock file
  if [ -f "${MOCK_FILE}" ]; then rm -rfv "${MOCK_FILE}"; fi;

fi;

# ------------------------------------------------------------
#
# find + while-loop
#

if [[ 1 -eq 1 ]]; then

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

fi;

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
#   stackoverflow.com  |  "How do I use a for-each loop to iterate over file paths in bash?"  |  https://stackoverflow.com/a/15066129
#
#   stackoverflow.com  |  "Loop through a comma-separated shell variable - Stack Overflow"  |  https://stackoverflow.com/a/27703327
#
#   stackoverflow.com  |  "Loop through an array of strings in Bash?"  |  https://stackoverflow.com/a/8880633
#
#   www.cyberciti.biz  |  "Bash For Loop Examples - nixCraft"  |  https://www.cyberciti.biz/faq/bash-for-loop/
#
#   www.cyberciti.biz  |  "How do I check my bash version? - nixCraft"  |  https://www.cyberciti.biz/faq/how-do-i-check-my-bash-version/
#
# ------------------------------------------------------------