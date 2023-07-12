#!/bin/bash
# ------------------------------------------------------------
#
# Get info on users
#

getent passwd;  # Get info on all users

getent passwd "${USER}" "www-data";  # Get info on multiple users

getent passwd "${USER}";  # Get info on single user


# ------------------------------------------------------------
#
# Get info on [user] groups
#

getent group;  # Get info on all users

getent group "${USER}" "www-data";  # Get info on multiple users

getent group "${USER}";  # Get info on single user


# ------------------------------------------------------------
#
# Get info on network hosts
#

getent ahosts;  # Get info on all network hosts

getent ahosts "example.com" "google.com";  # Get info on multiple network hosts

getent ahosts "example.com";  # Get info on single network host


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "dns - How to test /etc/hosts - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/134144
#
# ------------------------------------------------------------