#!/bin/bash
# ------------------------------------------------------------

# Linux - Clear the cached/saved terminal history
#    Distros: Debian, Ubuntu, etc.

history -c; if [ -f "${HOME}/.bash_history" ]; then rm --verbose "${HOME}/.bash_history"; fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   man7.org  |  history(3) - Linux manual page”  |  https://man7.org/linux/man-pages/man3/history.3.html
#
#   www.cyberciti.biz |  “How To Clear Shell History In Ubuntu Linux - nixCraft”  |  https://www.cyberciti.biz/faq/clear-the-shell-history-in-ubuntu-linux/
#
# ------------------------------------------------------------