#!/bin/bash
# ------------------------------------------------------------
#
# !!! USE [ usermod -s SHELL USERNAME ] INSTEAD OF chsh !!!
#
# ------------------------------------------------------------

# GENERAL USER DISABLE:
USER_NAME="bar"; usermod --expiredate "1" --shell "$(which nologin)" "${USER_NAME}";

# (UNDO DISABLE) GENERAL USER RE-ENABLE:
USER_NAME="bar"; usermod --expiredate "" --shell "$(which bash)" "${USER_NAME}";


# ------------------------------------------------------------

# Set the current user to use /bin/bash as default shell

chsh -s /bin/bash

# (Just add "/bin/bash" to the end of the user in /etc/passwd, like such)

username:x:1010:1010::/home/username:/bin/bash


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "ssh - Disable user shell for security reasons - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/174838
#
# ------------------------------------------------------------