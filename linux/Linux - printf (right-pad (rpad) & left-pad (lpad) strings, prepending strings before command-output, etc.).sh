#!/bin/sh
# ------------------------------------------------------------


# printf - right-pad (rpad) a string with spaces
TEST_PADDING="rpad"; echo "[$(printf '%-10s' "$TEST_PADDING";)]";


# printf - left-pad (lpad) a string with spaces
TEST_PADDING="lpad"; echo "[$(printf '%10s' "$TEST_PADDING";)]";


# ------------------------------------------------------------


# printf - prepending strings before command-output
find "/var/log/" \
-type f \
-iname syslog* \
-exec printf "$(date +'%Y-%m-%d %H:%M:%S') $(whoami)@$(hostname) | " \; \
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