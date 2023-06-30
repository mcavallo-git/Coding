#!/bin/sh
# ------------------------------------------------------------
# Linux - php (get .ini file locations)
# ------------------------------------------------------------

if [[ 1 -eq 1 ]]; then

  # php --ini

  FULLPATH_PHP_INI="$(php --ini | sed -rne "s/^Loaded Configuration File:\s*(.+)\s*$/\1/p";)";
  FULLPATH_PHP_CONF_D="$(php --ini | sed -rne "s/^Scan for additional .ini files in:\s*(.+)\s*$/\1/p";)";

  echo "";
  echo "FULLPATH_PHP_INI:     ${FULLPATH_PHP_INI}";
  echo "";
  echo "FULLPATH_PHP_CONF_D:  ${FULLPATH_PHP_CONF_D}";
  echo "";

fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "linux - Where can I find php.ini? - Stack Overflow"  |  https://stackoverflow.com/a/8684638
#
# ------------------------------------------------------------