#!/bin/sh
#
# ------------------------------------------------------------
# 
# Linux - sed
# 	--> parse nginx runtime user's name from nginx.conf
#
if [ -f "/etc/nginx/nginx.conf" ]; then
	NGINX_UNAME=$(sed --regexp-extended --quiet --expression='s/^user ([a-z_][a-z0-9_\-]{0,30}[a-z0-9_\-\$]?)\s*;\s*$/\1/p' "/etc/nginx/nginx.conf");
	NGINX_GNAME=$(id -gn "${NGINX_UNAME}");
	NGINX_UID=$(id -u "${NGINX_UNAME}");
	NGINX_GID=$(id -g "${NGINX_UNAME}");
fi;
#
#
# ------------------------------------------------------------
# 
# Linux - sed
# 	--> parse GnuPG key_id's out of gpg's 'LONG' formated-values
#
GnuPG_KeyIDs=$(gpg --list-secret-keys --keyid-format 'LONG' | sed --regexp-extended --quiet --expression='s/^sec\ +([A-Za-z0-9]+)\/([A-F0-9]{16})\ +([0-9\-]{1,10})\ +(.+)$/\2/p');
echo "GnuPG_KeyIDs=\"${GnuPG_KeyIDs}\"";
#
# ------------------------------------------------------------


