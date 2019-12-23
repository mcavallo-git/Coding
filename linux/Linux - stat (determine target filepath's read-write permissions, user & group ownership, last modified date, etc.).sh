#!/bin/bash
# 
# ------------------------------------------------------------


# For user/group file ownership, refer to "get_permissions" script @ https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master/usr/local/bin/get_permissions


# %w     time of file birth, human-readable; - if unknown
# %x     time of last access, human-readable
# %y     time of last data modification, human-readable
# %z     time of last status change, human-readable
stat --dereference --format="%w   %x   %y   %z" "${HOME}";
