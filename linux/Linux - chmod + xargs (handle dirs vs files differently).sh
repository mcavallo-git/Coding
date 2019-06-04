

# UPDATED_METHOD

find "/var/www/html" -type d -exec chmod 0755 '{}' \; # directories

find "/var/www/html" -type f -exec chmod 0644 '{}' \; # files





# DEPRECATED METHOD:

# find "/var/www/html" -type d -print0 | xargs -0 chmod 0775; # directories

# find "/var/www/html" -type f -print0 | xargs -0 chmod 0664; # files



