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
# Parse GnuPG key_id's out of gpg's 'LONG' formated-values
#
GnuPG_KeyIDs=$(gpg --list-secret-keys --keyid-format 'LONG' | sed --regexp-extended --quiet --expression='s/^sec\ +([A-Za-z0-9]+)\/([A-F0-9]{16})\ +([0-9\-]{1,10})\ +(.+)$/\2/p');
echo "GnuPG_KeyIDs=\"${GnuPG_KeyIDs}\"";



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
# 	Thanks to StackExchange user [ Janito Vaqueiro Ferreira Filho ] on forum [ https://stackoverflow.com/questions/12918292 ]
#
# ------------------------------------------------------------