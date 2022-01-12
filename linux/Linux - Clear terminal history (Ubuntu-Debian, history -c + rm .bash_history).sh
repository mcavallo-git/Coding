#!/bin/bash
# ------------------------------------------------------------

# Linux - Clear the cached/saved terminal history
#    Distros: Debian, Ubuntu, etc.

history -c; if [[ -f "${HOME}/.bash_history" ]]; then rm -rfv "${HOME}/.bash_history"; fi; if [[ -d "${HOME}/.bash-logs" ]]; then rm -rfv "${HOME}/.bash-logs"; mkdir -pv "${HOME}/.bash-logs"; chmod -v 0700 "${HOME}/.bash-logs"; fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   man7.org  |  history(3) - Linux manual page”  |  https://man7.org/linux/man-pages/man3/history.3.html
#
#   www.cyberciti.biz |  “How To Clear Shell History In Ubuntu Linux - nixCraft”  |  https://www.cyberciti.biz/faq/clear-the-shell-history-in-ubuntu-linux/
#
# ------------------------------------------------------------