#!/bin/sh
# ------------------------------------------------------------


# RPad (Right-Pad)  -->  w/ SPACES
STRING="rpad"; LENGTH="10"; echo "[$(printf "%-${LENGTH}s" "${STRING}";)]";


# RPad (Right-Pad)  -->  w/ ZEROES
FLOAT="123.45"; LENGTH="10"; echo "${FLOAT}" | awk '{printf "%*.*f\n", FL, FL-1-length(int($1)), $1}' FL="${LENGTH}";


# LPad (Left-Pad)  -->  w/ SPACES
STRING="lpad"; LENGTH="10"; echo "[ $(printf "%${LENGTH}s" "${STRING}";)]";


# LPad (Left-Pad)  -->  w/ ZEROES
INTEGER="12345"; LENGTH="10"; echo "[$(printf "%0${LENGTH}d" "${INTEGER}";)]";
FLOAT="123.45"; LENGTH="10"; LENGTH_DECIMALS="3"; echo "[$(printf "%0${LENGTH}.${LENGTH_DECIMALS}f" "${FLOAT}";)]";


# ------------------------------------------------------------


# printf - prepending strings before command-output
find "/var/log/" \
-type f \
-iname syslog* \
-exec printf "$(date --utc +'%Y-%m-%dT%H:%M:%S.%NZ';) $(whoami)@$(hostname) | " \; \
-exec echo "------------------------------------------------------------" \; \
-exec cat '{}' \; \
-exec echo "------------------------------------------------------------" \; \
;


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "Bash add trailing spaces to justify string - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/354094
#
# ------------------------------------------------------------