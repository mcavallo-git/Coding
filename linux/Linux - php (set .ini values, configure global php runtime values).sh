#!/bin/sh
# ------------------------------------------------------------
# Linux - php (set .ini values, configure global php runtime values)
# ------------------------------------------------------------

if [[ 1 -eq 1 ]]; then

  # php --ini

  PHP_INI_STOCK="$(php --ini | sed -rne "s/^Loaded Configuration File:\s*(.+)\s*$/\1/p";)";
  PHP_OVERRIDES="$(php --ini | sed -rne "s/^Scan for additional .ini files in:\s*(.+)\s*$/\1/p";)";
  PHP_OVERRIDE_INI="${PHP_OVERRIDES}/zzz_php_overrides.ini";

  echo "";
  echo "PHP_INI_STOCK:     ${PHP_INI_STOCK}";
  echo "PHP_OVERRIDES:     ${PHP_OVERRIDES}";
  echo "PHP_OVERRIDE_INI:  ${PHP_OVERRIDE_INI}";
  echo "";
  
  php -r 'echo ini_get("memory_limit");'; echo "";  # Outputs the stock value from "${PHP_INI_STOCK}"

  # Setup override .ini file
  echo "[PHP]" > "${PHP_OVERRIDE_INI}";
  echo "memory_limit = 1024M" >> "${PHP_OVERRIDE_INI}";

  php -r 'echo ini_get("memory_limit");'; echo "";  # Outputs the override value from "${PHP_OVERRIDE_INI}"

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