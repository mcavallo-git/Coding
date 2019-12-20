#!/bin/sh
#
# Linux - sed
#

#
# Simple Example ) Replace substrings within strings
#
echo "hello world" | sed -e 's|world|not world|g';


# ------------------------------------------------------------
#
# Example)  Enable/Disable Linux's MOTD (Message of the Day) feature
#

# Disable MOTD (Message of the Day)
sudo sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e "/^ENABLED=/c\ENABLED=0" "/etc/default/motd-news";

# Enable MOTD (Message of the Day)
sudo sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e "/^ENABLED=/c\ENABLED=1" "/etc/default/motd-news";


# ------------------------------------------------------------
#
# Example)  Comment out lines starting with [ ... ]
#

### MongoDB - Disable Replication
systemctl stop mongod; \
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e '/^replication:/ s/^#*/#/' "/etc/mongod.conf"; \
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e '/^  replSetName:/ s/^#*/#/' "/etc/mongod.conf"; \
systemctl start mongod;


### Bash - Disable "You have new mail in /var/spool/mail/..." alerts
if [ -n "$(sed -rne 's/^\s*MAIL=.*$/\0/p' '/etc/profile' 2>'/dev/null';)" ]; then \
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -re '/^\s*MAIL=.*$/ s/^#*/#/' "/etc/profile"; \
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
# Use sed with piped-commands to parse their output, line-by-line
#

printenv | grep -i 'onedrive' | sed -rne 's/^([a-zA-Z0-9]+)=(.+)$/\2/pi';


# ------------------------------------------------------------
# 
# sed
#  |-->  -i"..."  -->  create a backup-copy of the file with "..." extension appended to filename, then edit the file directly
#  |-->  -e '/.../d'  -->  remove specific lines, matching a given pattern
#

sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e '/pattern to match/d' ./infile


# ------------------------------------------------------------
#
#        [[:space:]]
#               Example: trim whitespace off of the beginning & end of a string
#

JAVA_ARGS="$(echo -e "${JAVA_ARGS}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')";


# ------------------------------------------------------------
#
#        -i[SUFFIX], --in-place[=SUFFIX]
#               edit files in place (makes backup if SUFFIX supplied)
#

sed_remove_whitespace_lines='/^\s*$/d';
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e "${sed_remove_whitespace_lines}" "FILEPATH";

sed_remove_starting_whitespace='s/^\s*//g';
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e "${sed_remove_starting_whitespace}" "FILEPATH";


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
# Use sed to search a file for lines starting/ending with specific string(s)
# 
# Example) Only return lines which start with "from" and end with "where"
#
if [ -n "$(sed -n -e '/from/,/where/ p' file.txt)" ]; then
	echo "File DOES contain substring"; # ==> Note: outputs entire file-contents if a match is found
else
	echo "File does NOT contain substring";
fi;


# ------------------------------------------------------------
#
# sed + head + sed
#   |--> Remove top 1 line from piped output
#
df -h | sed '1!G;h;$!d' | head -n -1 | sed '1!G;h;$!d'; 


# ------------------------------------------------------------
# sed + head + sed
#   |--> Remove top X lines from piped output
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
# Example)  Determine local Java runtime's home-directory ( $JAVA_HOME )
#
if [ $(which java 1>'/dev/null' 2>&1; echo $?;) -eq 0 ]; then

# Note: Java outputs to STDERR (2) by default - Redirect its output to STDOUT (1) by using 2>&1
JAVA_ALL_SETTINGS="$(java -XshowSettings:properties -version 2>&1)";
LOCAL_JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 | sed -rne 's/^\s*java.home = (.+)\s*$/\1/p';); echo "${LOCAL_JAVA_HOME}";

fi;


# ------------------------------------------------------------
# 
# Example)  Parse NGINX runtime user's name from nginx.conf
#
if [ -f "/etc/nginx/nginx.conf" ]; then
NGINX_UNAME=$(sed -rne 's/^user ([a-z_][a-z0-9_\-]{0,30}[a-z0-9_\-\$]?)\s*;\s*$/\1/p' "/etc/nginx/nginx.conf";);
# NGINX_UNAME=$(sed -rne 's/^user ([a-z_][a-z0-9_\-]{0,30}[a-z0-9_\-\$]?)\s*;\s*$/\1/p' "/etc/nginx/nginx.conf";);
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
# 	www.gnu.org  |  "sed, a stream editor"  |  https://www.gnu.org/software/sed/manual/sed.html#Multiline-techniques
#
# 	stackoverflow.com  |  "Delete lines in a text file that contain a specific string"  |  https://stackoverflow.com/a/5410784
#
# 	stackoverflow.com  |  "Grep Access Multiple lines, find all words between two patterns"  |  https://stackoverflow.com/questions/12918292
#
# 	stackoverflow.com  |  "How can I reverse the order of lines in a file?"  |  https://stackoverflow.com/a/744093
#
# 	stackoverflow.com  |  "Sed - An Introduction and Tutorial by Bruce Barnett"  |  https://www.grymoire.com/Unix/Sed.html#uh-42
#
# 	stackoverflow.com  |  "How can I reverse the order of lines in a file?"  |  https://stackoverflow.com/a/744093
#
# ------------------------------------------------------------