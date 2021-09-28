#!/bin/bash
# ------------------------------------------------------------


CHECKOUT_BRANCH="$(if [ "$(git rev-parse --abbrev-ref HEAD;)" != "HEAD" ]; then git rev-parse --abbrev-ref HEAD; else git symbolic-ref --short HEAD; fi;)"; echo "CHECKOUT_BRANCH=[${CHECKOUT_BRANCH}]";


COMMIT_HASH="$(git rev-parse HEAD;)";  echo "COMMIT_HASH=[${COMMIT_HASH}]";


COMMIT_TIMESTAMP="$(git log -1 --format="%h %ad" --date=format:'%Y%m%dT%H%M%S%z';)";  echo "COMMIT_TIMESTAMP=[${COMMIT_TIMESTAMP}]";


# ------------------------------------------------------------


# Get the last 10 commits
git log --oneline --max-count 10;


# ------------------------------------------------------------
#
# git log --date=format:'...' (placeholders):
#
#   %a      Abbreviated weekday name
#   %A      Full weekday name
#   %b      Abbreviated month name
#   %B      Full month name
#   %c      Date and time representation appropriate for locale
#   %d      Day of month as decimal number (01 – 31)
#   %H      Hour in 24-hour format (00 – 23)
#   %I      Hour in 12-hour format (01 – 12)
#   %j      Day of year as decimal number (001 – 366)
#   %m      Month as decimal number (01 – 12)
#   %M      Minute as decimal number (00 – 59)
#   %p      Current locale's A.M./P.M. indicator for 12-hour clock
#   %S      Second as decimal number (00 – 59)
#   %U      Week of year as decimal number, with Sunday as first day of week (00 – 53)
#   %w      Weekday as decimal number (0 – 6; Sunday is 0)
#   %W      Week of year as decimal number, with Monday as first day of week (00 – 53)
#   %x      Date representation for current locale
#   %X      Time representation for current locale
#   %y      Year without century, as decimal number (00 – 99)
#   %Y      Year with century, as decimal number
#   %z, %Z  Either the time-zone name or time zone abbreviation, depending on registry settings
#   %%      Percent sign
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   git-scm.com  |  "Git - git-log Documentation"  |  https://git-scm.com/docs/git-log
#
#   stackoverflow.com  |  "command line - How to change Git log date formats - Stack Overflow"  |  https://stackoverflow.com/a/34778736
#
# ------------------------------------------------------------