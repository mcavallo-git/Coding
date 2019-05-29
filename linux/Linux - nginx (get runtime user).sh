id -u www-data
| sed --expression="/^HOSTNAME=/c\HOSTNAME=${SUBDOMAIN}" "${HOSTNAME_STARTUP_FILE}";

sed --expression="^user " "/etc/nginx/nginx/conf"