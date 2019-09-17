#!/bin/sh
#
# Linux - sed
#


# ------------------------------------------------------------
# 
# Use sed to (essentially) 'cat' a file, remove whitespace-only lines from its
# output, then print the resultant output to the terminal (standard-output)
#
sed --expression='/^\s*$/d' "/etc/hosts";


# ------------------------------------------------------------
# 
# Use sed to remove one, specific line from a file (while also backing-up the original with a timestamp+".bak" extension)
#
sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" --expression='/pattern to match/d' ./infile


# ------------------------------------------------------------
# 
# Use sed's "--in-place" command to save sed's output directly to the file
# (e.g. modify/parse/regex-strip/regex-replace/etc. the contents of a file through sed)
#
sed_remove_whitespace_lines='/^\s*$/d';
sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" --expression="${sed_remove_whitespace_lines}" "FILEPATH";

sed_remove_starting_whitespace='s/^\s*//g';
sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" --expression="${sed_remove_starting_whitespace}" "FILEPATH";


# ------------------------------------------------------------
# 
# sed also contains prebuilt methods to:
#		Add [lines of] text BEFORE the matched-text
#		Add [lines of] text AFTER the matched-text
#		Modify the matched-text, including  modifying it to be [blank] to erase it entirely
#		 |--> Additionally, you can use 'c\' to change the entire line that the matched-text was on
#

sed '
/MATCH THIS TEXT/ {
i\
Add this line before
a\
Add this line after
c\
Change the line to this one
}';


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
# Example)  Enable/Disable the "Message of the Day" (MOTD) Feature in Linux
#
sudo sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" --expression="/^ENABLED=/c\ENABLED=0" "/etc/default/motd-news"; # Disable MOTD
sudo sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" --expression="/^ENABLED=/c\ENABLED=1" "/etc/default/motd-news"; # Enable MOTD


# ------------------------------------------------------------
# 
# Example)  Remove windows-newlines (e.g. remove CR's)
#
sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" --expression='s/\r$//' "~/sftp/uploaded_file";


# ------------------------------------------------------------
#
# Example)  MySQL Exports - Replace Function definers with 'CURRENT_USER()' --> Note: Pipes '|' do not require slashes '/' or '\' to be escaped
#
sed -i 's|DEFINER=[^ ]* FUNCTION|DEFINER=CURRENT_USER() FUNCTION|g' "Functions.sql"


# ------------------------------------------------------------
#
# Example)  MySQL Exports - Replace Trigger definers with 'CURRENT_USER()' --> Note: Pipes '|' do not require slashes '/' or '\' to be escaped
#
sed -i 's|DEFINER=[^ ]*\*/ |DEFINER=CURRENT_USER()*/ |g' "Triggers.sql"


# ------------------------------------------------------------
#
# Example)  GREP + SED - Get single line from file, then get substring from that line --> Note: This should probably be done exclusively with SED
#
echo $(cat "/etc/nginx/conf.d/nginx_ssl.conf" | grep 'ssl_ciphers ') | sed -e "s/ssl_ciphers '\(.*\)';/\1/"


# ------------------------------------------------------------
# 
# Example)  Parse GnuPG key_id's out of the fingerprints held in gpg (using 'LONG' format-syntax)
#
GnuPG_KeyIDs=$(gpg --list-secret-keys --keyid-format 'LONG' | sed --regexp-extended --quiet --expression='s/^sec\ +([A-Za-z0-9]+)\/([A-F0-9]{16})\ +([0-9\-]{1,10})\ +(.+)$/\2/p');
echo "GnuPG_KeyIDs=\"${GnuPG_KeyIDs}\"";


# ------------------------------------------------------------
# 
# Example)  Parse nginx runtime user's name from nginx.conf
#
if [ -f "/etc/nginx/nginx.conf" ]; then
	NGINX_UNAME=$(sed --regexp-extended --quiet --expression='s/^user ([a-z_][a-z0-9_\-]{0,30}[a-z0-9_\-\$]?)\s*;\s*$/\1/p' "/etc/nginx/nginx.conf");
	NGINX_GNAME=$(id -gn "${NGINX_UNAME}");
	NGINX_UID=$(id -u "${NGINX_UNAME}");
	NGINX_GID=$(id -g "${NGINX_UNAME}");
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
# 	stackoverflow.com  |  "Delete lines in a text file that contain a specific string"  |  https://stackoverflow.com/a/5410784
#
# 	stackoverflow.com  |  "Grep Access Multiple lines, find all words between two patterns"  |  https://stackoverflow.com/questions/12918292
#
# 	stackoverflow.com  |  "Sed - An Introduction and Tutorial by Bruce Barnett"  |  https://www.grymoire.com/Unix/Sed.html#uh-42
#
# ------------------------------------------------------------