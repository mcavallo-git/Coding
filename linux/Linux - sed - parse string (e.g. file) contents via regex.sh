#!/bin/sh
#
# Linux - sed
#
# ------------------------------------------------------------
#
# Simple Example ) Replace substrings within strings
#
echo "hello world" | sed -e 's|world|not world|g';


# ------------------------------------------------------------
# 
# Use sed with regex capture group(s) (which are referenced using \1 \2 ... \n - e.g. backslashed-numbers, instead of regex's usual $1 $2 ... $n - e.g. dollar-number syntax)
#


# Match lines in a file
if [ $(sed -rne "s/^(No issues found.)$/\1/p" "/var/log/npm-output/root" | wc -l;) -eq 0 ]; then
  echo "No lines matched";
else
  echo "At least one line matched!";
  MATCHED_LINES=$(sed -rne "s/^(No issues found.)$/\1/p" "/var/log/npm-output/root";);
  echo "\${MATCHED_LINES}=[${MATCHED_LINES}]";
fi;


# Match lines AND update file (using argument -i"...")
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -re "s/^(GRUB_CMDLINE_LINUX=\".+)\"\$/\1 crashkernel=auto\"/" "/etc/default/grub";


# Find & replace lines which match either [ hostname: ] or [ container_name: ] (update the value which comes after them)
NEW_DOCKER_NAME="dat-docker-name"; sed -i -re "s/^(\s+(hostname|container_name):\s+).+\$/\1\"${NEW_DOCKER_NAME}\"\3/" "./docker-compose.yml";

# Match lines from a curl request
TERRAFORM_LATEST_VERSION=$(curl https://www.terraform.io/downloads.html | grep 'https://releases.hashicorp.com/terraform/' | grep -i 'linux' | head -n 1 | sed -re "s/^.+https:\/\/releases\.hashicorp\.com\/terraform\/([0-9\.]+)\/.+$/\1/";);
echo "\${TERRAFORM_LATEST_VERSION}=[${TERRAFORM_LATEST_VERSION}]";


# ------------------------------------------------------------
# 
# Use sed with piped-commands to parse their output, line-by-line
#


# Example 1.1
printenv | grep -i 'onedrive' | sed -rne 's/^([a-zA-Z0-9]+)=(.+)$/\2/pi';


# Example 1.2
Example_CommaDelimitedList_RemoveMatchedItems="$(echo 'abc,defghij,klm' | sed 's/,/\n/g' | sed /^def*/d)"; echo "${Example_CommaDelimitedList_RemoveMatchedItems}";


# ------------------------------------------------------------
# 
# Bulk-Rename files by within a given working-directory using regex-matched variable(s)
#

WorkingDir="${HOME}\Downloads"; # Location containing files to-be-matched
Regex_FilenameMatches="Statement_(.+)_(.+)_(.+)\.pdf"; # Syntax for filenames to match
Sed_RegexExpression="s/${Regex_FilenameMatches}/\Statement_\3_\1_\2.pdf/"; # Syntax for filename replacement
if [ -d "${WorkingDir}" ]; then
echo "Setting working-directory to \"${WorkingDir}\"";
cd "${WorkingDir}";
find . -type f | while read EACH_FILENAME; do
NEW_FILENAME=$(echo ${EACH_FILENAME} | sed -re "${Sed_RegexExpression}";); # Pass the filename through the regex filter using sed
if [ -n "${NEW_FILENAME}" ] && [ "${EACH_FILENAME}" != "${NEW_FILENAME}" ]; then # If new filename is not blank (regex match) and is not equal to original filename, rename it
echo "  Renaming \"${EACH_FILENAME}\" to \"${NEW_FILENAME}\"";
mv "${EACH_FILENAME}" "${NEW_FILENAME}";
fi;
done;
fi;


# ------------------------------------------------------------
# 
# CamelCase a string with underscores (with or without the underscores in the output string)
#

BaseString="TEST_VARIABLE_NAME"; \
CamelCase_NoUnderscores=$(echo "${BaseString}" | sed -e 's/\(.*\)/\L\1/' | sed -r 's/(^|_)([a-z])/\U\2/g'); \
CamelCase_KeepUnderscores=$(echo "${BaseString}" | sed -e 's/\(.*\)/\L\1/' | sed -r 's/(^)([a-z])/\U\2/g' | sed -r 's/(_)([a-z])/_\U\2/g'); \
echo "\$BaseString=[${BaseString}]"; \
echo "\$CamelCase_NoUnderscores=[${CamelCase_NoUnderscores}]"; \
echo "\$CamelCase_KeepUnderscores=[${CamelCase_KeepUnderscores}]";


# ------------------------------------------------------------
# 
# Remove duplicated lines in a target file (while keeping one copy of each line)
#

TEMP_SSHD="/tmp/sshd_config_$(date +'%s.%N')"; \
echo "$(tac ${TEMP_SSHD};)" > "${TEMP_SSHD}";
echo "$(cat -n ${TEMP_SSHD} | sort -uk2 | sort -nk1 | cut -f2-;)" > "${TEMP_SSHD}";
echo "$(tac ${TEMP_SSHD};)" > "${TEMP_SSHD}";
cat "${TEMP_SSHD}";


# ------------------------------------------------------------
#
# Example)  Enable/Disable Linux's MOTD (Message of the Day) feature
#

# Disable MOTD (Message of the Day) by replacing the whole line containing ENABLED
sudo sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e "/^ENABLED=/c\ENABLED=0" "/etc/default/motd-news";

# Enable MOTD (Message of the Day)
sudo sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e "/^ENABLED=/c\ENABLED=1" "/etc/default/motd-news";


# ------------------------------------------------------------
#
# Example)  Comment-out lines starting-with or containing a specific substring
#  |
#  |--> Uses the sed regex-replacement syntax of [ s/^#*/#/ ] or [ s/^#*/# / ] (for a space after the pound-sign "# ") to replace [ matched lines ] with [ their same value but with a pound-sign "#" prepended to them ]  -  https://www.gnu.org/software/sed/manual/html_node/The-_0022s_0022-Command.html
#


### Bash - Comment-out specific line(s) in local "/etc/hosts" file (to disable local dns resolution overrides for them)
###  |--> Note that the "/etc/hosts" file requires you to get its value, edit the value, then overwrite the files's contents completely (cannot edit it direcly using sed's "-i" argument)
HOSTS_IP="8.8.8.8"; HOSTS_FQDN="dns.google.com"; echo "$(sed -re "/^${HOSTS_IP} ${HOSTS_FQDN}\$/ s/^#*/# /" '/etc/hosts';)" > '/etc/hosts';


### Bash - Comment-out specific line(s) in local "/etc/profile" file (to disable "You have new mail in /var/spool/mail/..." alerts at login)
if [ -n "$(sed -rne 's/^\s*MAIL=.*$/\0/p' '/etc/profile' 2>'/dev/null';)" ]; then \
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -re '/^\s*MAIL=.*$/ s/^#*/# /' "/etc/profile"; \
fi;


### MongoDB - Comment-out specific line(s) in "/etc/mongod.conf" file (to disable replication)
systemctl stop mongod; \
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e '/^replication:/ s/^#*/# /' "/etc/mongod.conf"; \
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e '/^  replSetName:/ s/^#*/# /' "/etc/mongod.conf"; \
systemctl start mongod;


# ------------------------------------------------------------
#
# Example)  UN-comment lines starting-with or containing a specific substring
#

# Uncomment lines which match "# set bell-style none"
if [ -f '/etc/inputrc' ]; then
  if [ $(sed -rne 's/^#\s*(set\s+bell-style\s+none\s*)$/\0/p' '/etc/inputrc' | wc -l 2>'/dev/null';) -gt 0 ]; then
    ### Bash - Disable the bell sound effect (specifically intended for WSL (Windows Subsystem for Linux)) - https://stackoverflow.com/a/36726662
    BENCHMARK_START=$(date +'%s.%N');
    echo -e "\n""Info:  Setting bell-style the bell sound effect in \"/etc/inputrc\")";
    sed -i".${START_TIMESTAMP}.bak" -r -e 's/^#\s*(set\s+bell-style\s+none\s*)$/\1/' '/etc/inputrc';
    BENCHMARK_DELTA=$(echo "scale=4; ($(date +'%s.%N') - ${BENCHMARK_START})/1" | bc -l);
    test ${ARGS_DEBUG_MODE} -eq 1 && echo "  |--> Finished after ${BENCHMARK_DELTA}s";
  fi;
fi;


# ------------------------------------------------------------
#
#        -e script, --expression=script
#               add the script to the commands to be executed
#
#        -n, --quiet, --silent
#               suppress automatic printing of pattern space
#
#        -E, -r, --regexp-extended
#               use extended regular expressions in the script (for portability use POSIX -E).
#

sed -e '/^\s*$/d' "/etc/hosts";


# ------------------------------------------------------------
# 
# sed
#  |-->  -e '/.../d'  -->  remove specific lines, matching a given pattern
#  |-->  -i"..."  -->  create a backup-copy of the file with "..." extension appended to filename, then edit the file directly
#

sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e '/pattern to match/d' ./infile


# ------------------------------------------------------------
#
#  sed - Remove empty/blank/whitespace-only lines
#

# sed - Remove empty/blank/whitespace-only lines
echo -e "  line1\n\n  line3\n\n\n  line6\n\n\n\n  line10\n" | sed -e "/^\s*$/d";


# ------------------------------------------------------------
#
#  sed - Add a leading zero before the decimal point on a number
#

echo ".7213" | sed 's/\([^0-9]\|^\)\(\.[0-9]*\)/\10\2/g';


# ------------------------------------------------------------
#
#  sed - Trim leading/trailing whitespace off of a string   (e.g. remove spaces at the beginning & end of a string)
#

# sed - Trim leading whitespace
echo -e "  line1\n\n  line3\n\n\n  line6\n\n\n\n  line10\n" | sed -e "s/^\s*//g";

# sed - Trim leading whitespace && trailing whitespace (method 1 - 2x faster than method 2)
echo "  a  b  c  d  " | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//';
    # Example before
    echo "[$(echo "  a  b  c  d  ";)]";
    # Example after
    echo "[$(echo "  a  b  c  d  " | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//';)]";

# sed - Trim leading whitespace && trailing whitespace (method 2 - takes twice as long to run as method 1)
echo "  a  b  c  d  " | sed -e 's/^[ \t]*//;s/[ \t]*$//';
    # Example before
    echo "[$(echo "  a  b  c  d  ";)]";
    # Example after
    echo "[$(echo "  a  b  c  d  " | sed -e 's/^[ \t]*//;s/[ \t]*$//';)]";


# echo -e "  line1\n\n  line3\n\n\n  line6\n\n\n\n  line10\n" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//';
# echo -e "  line1\n\n  line3\n\n\n  line6\n\n\n\n  line10\n"  | sed -e 's/^[ \t]*//;s/[ \t]*$//';


# ------------------------------------------------------------
#
#        -i[SUFFIX], --in-place[=SUFFIX]
#               edit files in place (makes backup if SUFFIX supplied)
#

# Example - sed -i (inline edit - modifies target filepath)
FILEPATH="${HOME}/test-sed-i.example-1.txt";
echo -e "  line1\n\n  line3\n\n\n  line6\n\n\n\n  line10\n" > "${FILEPATH}";
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e "/^\s*$/d" "${FILEPATH}";  # sed - remove empty/whitespace-only lines
echo "FILEPATH=[${FILEPATH}]"; echo -e "CONTENTS=[\n$(cat "${FILEPATH}";)\n]"; rm -rfv "${FILEPATH}";

# Example - sed -i (inplace edit - modifies target filepath)
FILEPATH="${HOME}/test-sed-i.example-2.txt";
echo -e "  line1\n\n  line3\n\n\n  line6\n\n\n\n  line10\n" > "${FILEPATH}";
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e "s/^\s*//g" "${FILEPATH}";  # sed - trim leading whitespace
echo "FILEPATH=[${FILEPATH}]"; echo -e "CONTENTS=[\n$(cat "${FILEPATH}";)\n]"; rm -rfv "${FILEPATH}";


# ------------------------------------------------------------
# 
# sed also contains prebuilt methods to:
#		i\ Add [lines of] text BEFORE the matched-text
#		a\ Add [lines of] text AFTER the matched-text
#		c\ Modify the matched-text, including  modifying it to be [blank] to erase it entirely
#


# As a GNU extension, the i command and text can be separated into two -e parameters, enabling easier scripting:
seq 10 | sed -e '/7/i\' -e hello;


# Example)  Using a\ i\ c\
echo -e "$(seq 10;)\n$(seq 10;)" | sed -r -e "/^5$/{" -e "i\\BEFORE" -e "a\\AFTER" -e "c\\MATCHED" -e "}";


# Example)  Using a\ i\ c\ with variables
BEFORE="DAT_BEFORE_STRING"; AFTER="DAT_AFTER_STRING"; MATCHED="DAT_MATCHED_STRING";
echo -e "$(seq 10;)\n$(seq 10;)" | sed -r -e "/^5$/{" -e "i\\${BEFORE}" -e "a\\${AFTER}" -e "c\\${MATCHED}" -e "}";


# Example)  Using a\ i\ (adds text before / after match)
echo -e "$(seq 10;)\n$(seq 10;)" | sed -r -e "/^5$/{" -e "i\\BEFORE" -e "a\\AFTER" -e "}";


# Example)  Using a\ i\ with variables (adds text before / after match)
BEFORE="DAT_BEFORE_STRING"; AFTER="DAT_AFTER_STRING";
echo -e "$(seq 10;)\n$(seq 10;)" | sed -r -e "/^5$/{" -e "i\\${BEFORE}" -e "a\\${AFTER}" -e "}";



# ------------------------------------------------------------
#
# Search the contents of a file for lines starting/ending with specific string(s)
# 
#

# Example) Only return lines which start with "from" and end with "where"
if [ -n "$(sed -n -e '/from/,/where/ p' file.txt)" ]; then
	echo "File DOES contain substring"; # ==> Note: outputs entire file-contents if a match is found
else
	echo "File does NOT contain substring";
fi;


# ------------------------------------------------------------
#
# Remove top 1 line from piped output using [ sed + head + sed ]
#
df -h | sed '1!G;h;$!d' | head -n -1 | sed '1!G;h;$!d'; 


# ------------------------------------------------------------
#
# Remove top X lines from piped output using [ sed + head + sed ]
#
SED_REVERSE_METHOD1='1!G;h;$!d';  # use with  [ sed '1!G;h;$!d' ]
SED_REVERSE_METHOD2='1!G;h;$p';   # use with  [ sed -n '1!G;h;$p' ]
TOP_LINES_TO_SLICE=5;

TEST_STR="1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15"; \
echo "\${TEST_STR}, as-is (not-reversed):"; echo -e "${TEST_STR}"; \
 \
echo -e "\n\${TEST_STR}, reversed (using SED_REVERSE_METHOD1):";\
echo -e "${TEST_STR}" | sed "${SED_REVERSE_METHOD1}" | head -n -${TOP_LINES_TO_SLICE} | sed "${SED_REVERSE_METHOD1}"; \
echo -e "\n"; \
 \
echo -e "\n\${TEST_STR}, reversed (using SED_REVERSE_METHOD2):"; \
echo -e "${TEST_STR}" | sed -n "${SED_REVERSE_METHOD2}" | head -n -${TOP_LINES_TO_SLICE} | sed -n "${SED_REVERSE_METHOD2}"; echo -e "\n";


# ------------------------------------------------------------
# 
# Example)  Remove windows-newlines (e.g. remove CR's)
#
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e 's/\r$//' "~/sftp/uploaded_file";


# ------------------------------------------------------------
#
# Example)  Escape forward slashes using sed
#
EXAMPLE_SUBNETS_LIST="10.0.0.0/8"$'\n'"172.16.0.0/12"$'\n'"192.168.0.0/16";
EXAMPLE_SUBNET_TO_REMOVE="172.16.0.0/12";
SED_ESCAPED_FORWARD_SLASHES="$(echo ${EXAMPLE_SUBNET_TO_REMOVE} | sed 's/\//\\\//g')";
SED_EXPRESSION="/^${SED_ESCAPED_FORWARD_SLASHES}*/d";
echo "${EXAMPLE_SUBNETS_LIST}" | sed ${SED_EXPRESSION};


# ------------------------------------------------------------
#
# Example)  MySQL Exports - Replace Function definers with 'CURRENT_USER()' --> Note: Pipes '|' do not require slashes '/' or '\' to be escaped
#
sed -i 's|DEFINER=[^ ]* FUNCTION|DEFINER=CURRENT_USER() FUNCTION|g' "Functions.sql"

sed -i 's|DEFINER=[^ ]* FUNCTION|DEFINER=CURRENT_USER() FUNCTION|g' "Functions.sql"


# ------------------------------------------------------------
#
# Example)  MySQL Exports - Replace Trigger definers with 'CURRENT_USER()' --> Note: Pipes '|' do not require slashes '/' or '\' to be escaped
#
sed -i 's|DEFINER=[^ ]*\*/ |DEFINER=CURRENT_USER()*/ |g' "Triggers.sql"


# ------------------------------------------------------------
# 
# Example)  Parse GnuPG key_id's out of the fingerprints held in gpg (using 'LONG' format-syntax)
#
GnuPG_KeyIDs=$(gpg --list-secret-keys --keyid-format 'LONG' | sed -rne 's/^sec\ +([A-Za-z0-9]+)\/([A-F0-9]{16})\ +([0-9\-]{1,10})\ +(.+)$/\2/p');
echo "GnuPG_KeyIDs=\"${GnuPG_KeyIDs}\"";


# ------------------------------------------------------------
# 
# Example)  Java - Parse values from local config
#
if [ $(which java 1>'/dev/null' 2>&1; echo $?;) -eq 0 ]; then

# Show local Java runtime's settings/properties
JAVA_ALL_SETTINGS="$(java -XshowSettings:properties -version 2>&1;)"; echo "JAVA_ALL_SETTINGS = [ ${JAVA_ALL_SETTINGS} ]";  # Note: Java outputs to STDERR (2) by default - Redirect its output to STDOUT (1) by using 2>&1

# Locate $JAVA_HOME (local Java runtime's home-directory)
LOCAL_JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 | sed -rne 's/^\s*java.home = (.+)\s*$/\1/p';); echo "LOCAL_JAVA_HOME = [ ${LOCAL_JAVA_HOME} ]";  # Note: Java outputs to STDERR (2) by default - Redirect its output to STDOUT (1) by using 2>&1

# Locate Font-files within JAVA_HOME
find "${LOCAL_JAVA_HOME}" -iname '*font*';
fi;


# ------------------------------------------------------------
# 
# Example)  Parse Terraform's latest version from their downloads URL ( as they intentionally do not provide a pointer to the "latest" version of Terraform - reference: https://github.com/hashicorp/terraform/issues/9803 )
#
TERRAFORM_LATEST_VERSION=$(curl https://www.terraform.io/downloads.html | grep 'https://releases.hashicorp.com/terraform/' | grep -i 'linux' | head -n 1 | sed -re "s/^.+https:\/\/releases\.hashicorp\.com\/terraform\/([0-9\.]+)\/.+$/\1/");
echo "\${TERRAFORM_LATEST_VERSION}=[${TERRAFORM_LATEST_VERSION}]";


# ------------------------------------------------------------
# 
# Example)  Parse NGINX runtime user's name from nginx.conf
#
if [ -f "/etc/nginx/nginx.conf" ]; then
NGINX_UNAME=$(sed -rne 's/^user ([a-z_][a-z0-9_\-]{0,30}[a-z0-9_\-\$]?)\s*;\s*$/\1/p' "/etc/nginx/nginx.conf";);
NGINX_GNAME=$(id -gn "${NGINX_UNAME}";);
NGINX_UID=$(id -u "${NGINX_UNAME}";);
NGINX_GID=$(id -g "${NGINX_UNAME}";);
fi;


# ------------------------------------------------------------
#
# Example)  GREP + SED - Get single line from file, then get substring from that line --> Note: This should probably be done exclusively with SED
#
echo $(cat "/etc/nginx/conf.d/nginx_ssl.conf" | grep 'ssl_ciphers ') | sed -e "s/ssl_ciphers '\(.*\)';/\1/"


# ------------------------------------------------------------
#
# Citation(s)
#
#   codereview.stackexchange.com  |  "regex - Transform snake_case to camelCase with sed - Code Review Stack Exchange"  |  https://codereview.stackexchange.com/a/140424
#
#   docs.oracle.com  |  "Font Configuration Files"  |  https://docs.oracle.com/javase/8/docs/technotes/guides/intl/fontconfig.html
#
#   docs.oracle.com  |  "java.awt (SE-8) - Class Font"  |  https://docs.oracle.com/javase/8/docs/api/java/awt/Font.html
#
#   docstore.mik.ua  |  "A.3 Command Summary for sed docstore.mik.ua/orelly/unix/sedawk/appa_03.htm"  |  https://docstore.mik.ua/orelly/unix/sedawk/appa_03.htm
#
#   stackoverflow.com  |  "bash - Disable beep in WSL terminal on Windows 10 - Stack Overflow"  |  https://stackoverflow.com/a/36726662
#
#   stackoverflow.com  |  "bash - How to add leading zeros before decimal points in a file - Stack Overflow"  |  https://stackoverflow.com/a/40787442
#
#   stackoverflow.com  |  "Delete lines in a text file that contain a specific string"  |  https://stackoverflow.com/a/5410784
#
#   stackoverflow.com  |  "Grep Access Multiple lines, find all words between two patterns"  |  https://stackoverflow.com/questions/12918292
#
#   stackoverflow.com  |  "How can I reverse the order of lines in a file?"  |  https://stackoverflow.com/a/744093
#
#   stackoverflow.com  |  "regex - sed one-liner to convert all uppercase to lowercase? - Stack Overflow"  |  https://stackoverflow.com/a/4581564
#
#   stackoverflow.com  |  "Sed - An Introduction and Tutorial by Bruce Barnett"  |  https://www.grymoire.com/Unix/Sed.html#uh-42
#
#   unix.stackexchange.com  |  "How can I use sed to replace a multi-line string?"  |  https://unix.stackexchange.com/a/26290
#
#   unix.stackexchange.com  |  "linux - Remove duplicate lines from a file but leave 1 occurrence"  |  https://unix.stackexchange.com/a/504047
#
#   unix.stackexchange.com  |  "shell script - Convert underscore to PascalCase, ie UpperCamelCase - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/196241
#
#   unix.stackexchange.com  |  "shell script - How do I trim leading and trailing whitespace from each line of some output? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/102021
#
#   www.cyberciti.biz  |  "Linux Shell – How To Remove Duplicate Text Lines"  |  www.cyberciti.biz/faq/unix-linux-shell-removing-duplicate-lines/
#
#   www.gnu.org  |  "sed, a stream editor"  |  https://www.gnu.org/software/sed/manual/sed.html#Multiline-techniques
#
#   www.gnu.org  |  "The "s" Command (sed, a stream editor)"  |  https://www.gnu.org/software/sed/manual/html_node/The-_0022s_0022-Command.html
#
# ------------------------------------------------------------