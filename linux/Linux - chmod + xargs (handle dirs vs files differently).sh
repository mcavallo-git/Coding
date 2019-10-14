#!/bin/sh


# ------------------------------------------------------------
# chown → FASTER Method (piping find's results into xargs)

find "/var/www/html" -type d -print0 | xargs -0 chmod 0775; # directories

find "/var/www/html" -type f -print0 | xargs -0 chmod 0664; # files


# ------------------------------------------------------------
# chown → SLOWER Method (built-in "-exec" find method)

# find "/var/www/html" -type d -exec chmod 0755 '{}' \; # directories

# find "/var/www/html" -type f -exec chmod 0644 '{}' \; # files


# ------------------------------------------------------------