#!/bin/sh

# Linux - sed - parse nginx runtime user's name from nginx.conf
if [ -f "/etc/nginx/nginx.conf" ]; then
	NGINX_UNAME=$(sed --regexp-extended --quiet --expression='s/^user ([a-z_][a-z0-9_\-]{0,30}[a-z0-9_\-\$]?)\s*;\s*$/\1/p' "/etc/nginx/nginx.conf");
	NGINX_GNAME=$(id -gn "${NGINX_UNAME}");
	NGINX_UID=$(id -u "${NGINX_UNAME}");
	NGINX_GID=$(id -g "${NGINX_UNAME}");
fi;
