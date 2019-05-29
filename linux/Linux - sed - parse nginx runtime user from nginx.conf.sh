#!/bin/sh

# Linux - sed - parse nginx runtime user from nginx.conf

sed --regexp-extended --quiet --expression='s/^user ([a-z_][a-z0-9_\-]{0,30}[a-z0-9_\-\$]?)\s*;\s*$/\1/p' "/etc/nginx/nginx.conf";
