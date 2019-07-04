#!/bin/sh
#
# Linux - sed
#
# ------------------------------------------------------------
# 
# Parse nginx runtime user's name from nginx.conf
#
if [ -f "/etc/nginx/nginx.conf" ]; then
	NGINX_UNAME=$(sed --regexp-extended --quiet --expression='s/^user ([a-z_][a-z0-9_\-]{0,30}[a-z0-9_\-\$]?)\s*;\s*$/\1/p' "/etc/nginx/nginx.conf");
	NGINX_GNAME=$(id -gn "${NGINX_UNAME}");
	NGINX_UID=$(id -u "${NGINX_UNAME}");
	NGINX_GID=$(id -g "${NGINX_UNAME}");
fi;



# ------------------------------------------------------------
# 
# Add line before & after line via sed, and change the line as-well
#
#!/bin/sh
sed '
/WORD/ {
i\
Add this line before
a\
Add this line after
c\
Change the line to this one
}';



# ------------------------------------------------------------
# 
# Parse GnuPG key_id's out of gpg's 'LONG' formated-values
#
GnuPG_KeyIDs=$(gpg --list-secret-keys --keyid-format 'LONG' | sed --regexp-extended --quiet --expression='s/^sec\ +([A-Za-z0-9]+)\/([A-F0-9]{16})\ +([0-9\-]{1,10})\ +(.+)$/\2/p');
echo "GnuPG_KeyIDs=\"${GnuPG_KeyIDs}\"";



# ------------------------------------------------------------
# 
# Remove excessive whitespace from file
#

sed_remove_whitespace_lines='/^\s*$/d';
sed --in-place --expression="${sed_remove_whitespace_lines}" "FILEPATH";

sed_remove_starting_whitespace='s/^\s*//g';
sed --in-place --expression="${sed_remove_starting_whitespace}" "FILEPATH";



# ------------------------------------------------------------
# 
# Remove whitespace-only lines
#
sed --in-place --expression='/^\s*$/d' "/etc/hosts";
cat "/etc/hosts";



# ------------------------------------------------------------
# 
# Remove windows-newlines (e.g. remove CR's)
#
sed --in-place --expression='s/\r$//' "~/sftp/uploaded_file";



# ------------------------------------------------------------
#
# Search for substring by start+end substrings
#  |--> 1. Substring starts with "from" (start of substring)
#  |--> 2. Substring ends with "where" (end of substring)
#

if [ -n "$(sed -n -e '/from/,/where/ p' file.txt)" ]; then
	echo "File DOES contain substring"; # ==> Note: outputs entire file-contents if a match is found
else
	echo "File does NOT contain substring";
fi;



# ------------------------------------------------------------
#
# MySQL Exports - Replace Function definers with 'CURRENT_USER()'
# 	|--> Note: Pipes '|' do not require slashes '/' or '\' to be escaped

sed -i 's|DEFINER=[^ ]* FUNCTION|DEFINER=CURRENT_USER() FUNCTION|g' "Functions.sql"



# ------------------------------------------------------------
#
# MySQL Exports - Replace Trigger definers with 'CURRENT_USER()'
# 	|--> Note: Pipes '|' do not require slashes '/' or '\' to be escaped
#

sed -i 's|DEFINER=[^ ]*\*/ |DEFINER=CURRENT_USER()*/ |g' "Triggers.sql"



# ------------------------------------------------------------
#
# GREP + SED - Get single line from file, then get substring from that line
# 	|--> Note: This should probably be done exclusively with SED
#

echo $(cat "/etc/nginx/conf.d/nginx_ssl.conf" | grep 'ssl_ciphers ') | sed -e "s/ssl_ciphers '\(.*\)';/\1/"



# ------------------------------------------------------------
#
# Citation(s)
#
# 	stackoverflow.com  |  "Grep Access Multiple lines, find all words between two patterns"  |  https://stackoverflow.com/questions/12918292
#
# 	stackoverflow.com  |  "Sed - An Introduction and Tutorial by Bruce Barnett"  |  https://www.grymoire.com/Unix/Sed.html#uh-42
#
# ------------------------------------------------------------