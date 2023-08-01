#!/bin/bash
# ------------------------------------------------------------
#
# Determining what is taking up so much disk space on a Linux box, manually
#

cd "/";
du -d 0 "$(pwd)/"* 2>'/dev/null' | sort -n;

# |--> NEXT STEP:   look at bottom of list to determine which directories need to be delved into deeper

# |--> NEXT STEP:   recursively go into large directories and perform same "du ..." command until you locate files you feel are in the clear to removed


# ------------------------------------------------------------
#
# Filesize of each directory in $(pwd) + sort
#

cd "/var/log";
du -b -d 0 "$(pwd)/"* 2>'/dev/null' | sort -n;  # Equivalent to  [ du --max-depth=0 "$(pwd)/"* 2>'/dev/null' | sort --numeric-sort; ]


# Same as above but exclude [ .git/* ] nested directories
du -b -d 0 "${REPOS_DIR}/"* --exclude='.git/**/*' 2>'/dev/null' | sort -n;


# ------------------------------------------------------------
#
# Citation(s)
#
#   man7.org  |  "sort(1) - Linux manual page"  |  https://man7.org/linux/man-pages/man1/sort.1.html
#
# ------------------------------------------------------------