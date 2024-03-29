#!/bin/sh
# ------------------------------------------------------------
# Linux - php (get .ini file locations)
# ------------------------------------------------------------

if [[ 1 -eq 1 ]]; then

  # php --ini

  PHP_INI_STOCK="$(php --ini | sed -rne "s/^Loaded Configuration File:\s*(.+)\s*$/\1/p";)";
  PHP_OVERRIDES="$(php --ini | sed -rne "s/^Scan for additional .ini files in:\s*(.+)\s*$/\1/p";)";

  echo "";
  echo "PHP_INI_STOCK:  ${PHP_INI_STOCK}";
  echo "";
  echo "PHP_OVERRIDES:  ${PHP_OVERRIDES}";

  # Get a value from the ini
  echo "";
  echo -n "php.memory_limit:  ";
  php -r 'echo ini_get("memory_limit");';

  echo "";
  echo "";

fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "linux - Where can I find php.ini? - Stack Overflow"  |  https://stackoverflow.com/a/8684638
#
#   www.php.net  |  "PHP: ini_get - Manual"  |  https://www.php.net/manual/en/function.ini-get
#
# ------------------------------------------------------------